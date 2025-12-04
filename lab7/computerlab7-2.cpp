#include <xmmintrin.h>
#include <smmintrin.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <chrono>

float** alloc_matrix(int N) {
    float **A = (float**)malloc(N * sizeof(float*));
    for (int i = 0; i < N; i++)
        A[i] = (float*)aligned_alloc(16, N*sizeof(float));
    return A;
}

void free_matrix(float **A, int N) {
    for (int i = 0; i < N; i++)
        free(A[i]);
    free(A);
}

float norm_inf(float **A, int N) {
    float m = 0.0f;
    for (int i = 0; i < N; i++) {
        float s = 0.0f;
        for (int j = 0; j < N; j++)
            s += fabsf(A[i][j]);
        if (s > m) m = s;
    }
    return m;
}

// ===== SIMD-умножение через SSE (по 4 float за раз) =====
void matmul_sse(float **C, float **A, float **B, int N) {
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j += 4) { // по 4 столбца
            __m128 c = _mm_setzero_ps();
            for (int k = 0; k < N; k++) {
                __m128 a = _mm_set1_ps(A[i][k]);
                __m128 b = _mm_load_ps(&B[k][j]); // B[k][j..j+3]
                c = _mm_add_ps(c, _mm_mul_ps(a, b));
            }
            _mm_store_ps(&C[i][j], c);
        }
}

int main() {
    int N = 2048;
    int M = 10;

    float **A   = alloc_matrix(N);
    float **AT  = alloc_matrix(N);
    float **B   = alloc_matrix(N);
    float **BA  = alloc_matrix(N);
    float **R   = alloc_matrix(N);
    float **Rk  = alloc_matrix(N);
    float **S   = alloc_matrix(N);
    float **TMP = alloc_matrix(N);

    srand(0);

    // ---------------------------
    // ✔ ТАЙМЕР CHRONO — НАЧАЛО
    // ---------------------------
    using clock_type = std::chrono::high_resolution_clock;
    auto t0 = clock_type::now();

    // 1) A случайная
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            A[i][j] = float(rand()%10 + 1);

    // 2) AT = A^T
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            AT[i][j] = A[j][i];

    // 3) Нормы
    float na  = norm_inf(A, N);
    float nat = norm_inf(AT, N);
    float alpha = na * nat;

    // 4) B = AT/alpha
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            B[i][j] = AT[i][j] / alpha;

    // 5) BA = B*A (через SIMD)
    matmul_sse(BA, B, A, N);

    // 6) R = I - BA
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            R[i][j] = (i == j ? 1.0f : 0.0f) - BA[i][j];

    // 7) S = I + R + R^2 + ... + R^(M-1)
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
            S[i][j]  = (i == j);
            Rk[i][j] = R[i][j];
        }

    for (int iter = 1; iter < M; iter++) {
        // S += Rk
        for (int i = 0; i < N; i++)
            for (int j = 0; j < N; j++)
                S[i][j] += Rk[i][j];

        // TMP = Rk * R  (через SIMD)
        matmul_sse(TMP, Rk, R, N);

        float **t = Rk;
        Rk = TMP;
        TMP = t;
    }

    // 8) A^{-1} ≈ B * S   (через SIMD)
    matmul_sse(TMP, B, S, N);

    // ---------------------------
    // ✔ ТАЙМЕР CHRONO — КОНЕЦ
    // ---------------------------
    auto t1 = clock_type::now();
    double secs = std::chrono::duration<double>(t1 - t0).count();

    printf("Готово (SSE)\n");
    printf("Время выполнения (SSE): %.6f сек\n", secs);

    free_matrix(A, N);
    free_matrix(AT, N);
    free_matrix(B, N);
    free_matrix(BA, N);
    free_matrix(R, N);
    free_matrix(Rk, N);
    free_matrix(S, N);
    free_matrix(TMP, N);
}
//g++ computerlab7-2.cpp -O3 -ffast-math -march=native -msse4.1 -o lab7_sse
