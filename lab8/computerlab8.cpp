#include <algorithm>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <numeric>
#include <random>
#include <string>
#include <vector>

#if defined(__x86_64__) || defined(_M_X64) || defined(__i386) || defined(_M_IX86)
  #include <immintrin.h>
  static inline uint64_t rdtsc_start() {
      unsigned int aux;
      _mm_lfence(); // не даёт процессору переставлять инструкции
      uint64_t t = __rdtsc(); // возвращает число тактов с момента включения процессора
      _mm_lfence();
      (void)aux;
      return t;
  }
  static inline uint64_t rdtsc_stop() {
      unsigned int aux = 0;
      _mm_lfence();
      uint64_t t = __rdtscp(&aux); // возвращает номер ядра (в aux) и число тактов
      _mm_lfence();
      return t;
  }
#else
  #error "Эта версия измеряет такты через RDTSC и требует x86/x86_64."
#endif

static void* aligned_alloc64(size_t bytes) {
#if defined(_MSC_VER)
    return _aligned_malloc(bytes, 64);
#else
    void* p = nullptr;
    if (posix_memalign(&p, 64, bytes) != 0) return nullptr;
    return p;
#endif
}

static void aligned_free64(void* p) {
#if defined(_MSC_VER)
    _aligned_free(p);
#else
    free(p);
#endif
}

enum class Mode { Forward, Backward, Random };

static const char* mode_name(Mode m) {
    switch (m) {
        case Mode::Forward:  return "forward";
        case Mode::Backward: return "backward";
        case Mode::Random:   return "random";
    }
    return "unknown";
}

// Заполнить x[0..N-1] так, чтобы образовался циклический односвязный список
static void fill_list(uint32_t* x, uint32_t N, Mode mode, std::mt19937& rng) {
    if (N == 0) return;

    if (mode == Mode::Forward) {
        for (uint32_t i = 0; i + 1 < N; ++i) x[i] = i + 1;
        x[N - 1] = 0;
        return;
    }

    if (mode == Mode::Backward) {
        x[0] = N - 1;
        for (uint32_t i = 1; i < N; ++i) x[i] = i - 1;
        return;
    }

    // Random: делаем случайную перестановку perm и связываем по ней цикл
    std::vector<uint32_t> perm(N);
    std::iota(perm.begin(), perm.end(), 0u);
    std::shuffle(perm.begin(), perm.end(), rng);

    for (uint32_t i = 0; i < N; ++i) {
        uint32_t cur = perm[i];
        uint32_t nxt = perm[(i + 1) % N];
        x[cur] = nxt;
    }
}

// Прогрев + измерение прохода по списку N*K раз
static uint64_t measure_cycles(const uint32_t* x, uint32_t N, uint64_t K) {
    volatile uint32_t k = 0;

    // Прогрев кэша (1 полный проход)
    for (uint32_t i = 0; i < N; ++i) k = x[k];

    // Измерение
    const uint64_t iters = (uint64_t)N * K;

    uint64_t t0 = rdtsc_start();
    for (uint64_t i = 0; i < iters; ++i) {
        k = x[k];
    }
    uint64_t t1 = rdtsc_stop();

    // Не дать компилятору выкинуть цикл
    asm volatile("" : : "r"(k) : "memory");

    return (t1 - t0);
}

// Генератор "достаточно плотных" размеров: N, 1.5N, 2N, 3N, 4N...
static std::vector<uint32_t> make_sizes(uint32_t n_min, uint32_t n_max) {
    std::vector<uint32_t> sizes;
    for (uint32_t n = n_min; n <= n_max; ) {
        sizes.push_back(n);
        uint64_t n15 = n + n / 2;  // 1.5x
        if (n15 <= n_max) sizes.push_back((uint32_t)n15);

        // следующий "крупный" шаг
        uint64_t n2 = (uint64_t)n * 2;
        if (n2 > n_max) break;
        n = (uint32_t)n2;
    }
    std::sort(sizes.begin(), sizes.end());
    sizes.erase(std::unique(sizes.begin(), sizes.end()), sizes.end());
    return sizes;
}

int main(int argc, char** argv) {
    // Параметры по умолчанию (можно менять аргументами)
    // n_min ~ 1KB: 256 * 4 = 1024 байта
    uint32_t n_min = 256;
    // n_max ~ 32MB: (32 * 1024 * 1024) / 4 = 8_388_608 элементов int32
    uint32_t n_max = 8'388'608;

    // Сколько раз мерить один и тот же N (берём минимум)
    int repeats = 7;

    // Целевое число обращений (чтобы замер был стабильный)
    // Реальное K = max(1, target_accesses / N)
    uint64_t target_accesses = 64'000'000ULL;

    if (argc >= 2) n_min = (uint32_t)std::stoul(argv[1]);
    if (argc >= 3) n_max = (uint32_t)std::stoul(argv[2]);
    if (argc >= 4) repeats = std::stoi(argv[3]);
    if (argc >= 5) target_accesses = std::stoull(argv[4]);

    if (n_min < 2) n_min = 2;
    if (n_max < n_min) std::swap(n_min, n_max);

    std::mt19937 rng(123456u);

    auto sizes = make_sizes(n_min, n_max);

    // CSV заголовок
    std::cout << "size_bytes,N,mode,K,cycles_total,cycles_per_access\n";

    for (uint32_t N : sizes) {
        size_t bytes = (size_t)N * sizeof(uint32_t);

        uint32_t* x = (uint32_t*)aligned_alloc64(bytes);
        if (!x) {
            std::cerr << "Не удалось выделить память: " << bytes << " bytes\n";
            return 1;
        }

        // под каждый N выбираем K так, чтобы суммарно было достаточно обращений
        uint64_t K = target_accesses / (uint64_t)N;
        if (K < 1) K = 1;

        for (Mode mode : {Mode::Forward, Mode::Backward, Mode::Random}) {
            fill_list(x, N, mode, rng);

            uint64_t best = UINT64_MAX;
            for (int r = 0; r < repeats; ++r) {
                uint64_t cycles = measure_cycles(x, N, K);
                if (cycles < best) best = cycles;
            }

            double per = (double)best / (double)((uint64_t)N * K);

            std::cout
                << bytes << ","
                << N << ","
                << mode_name(mode) << ","
                << K << ","
                << best << ","
                << per
                << "\n";
        }

        aligned_free64(x);
    }

    return 0;
}
/*
g++ -O1 -std=c++17 computerlab8.cpp -o lab8
./lab8 > out.csv
*/