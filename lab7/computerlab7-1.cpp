#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <chrono>

// --------- ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ ---------

float** alloc_matrix(int N) {
    float **A = (float**)malloc(N * sizeof(float*));
    if (!A) {
        fprintf(stderr, "alloc_matrix: malloc failed (rows)\n");
        exit(1);
    }
    for (int i = 0; i < N; i++) {
        A[i] = (float*)malloc(N * sizeof(float));
        if (!A[i]) {
            fprintf(stderr, "alloc_matrix: malloc failed (cols)\n");
            exit(1);
        }
    }
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

void mat_mul(float **C, float **A, float **B, int N) {
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
            float s = 0.0f;
            for (int k = 0; k < N; k++)
                s += A[i][k] * B[k][j];
            C[i][j] = s;
        }
}

// --------- ОСНОВНАЯ ПРОГРАММА (NAIVE) ---------

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
    float **tmp = alloc_matrix(N);

    srand(0);

    using clock_type = std::chrono::high_resolution_clock;
    auto start = clock_type::now();

    // 1) Инициализация матрицы A
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            A[i][j] = (float)(rand() % 10 + 1);

    // 2) AT = A^T
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            AT[i][j] = A[j][i];

    // 3) Нормы
    float na  = norm_inf(A,  N);
    float nat = norm_inf(AT, N);
    float alpha = na * nat;

    // 4) B = AT / alpha
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            B[i][j] = AT[i][j] / alpha;

    // 5) BA = B * A (наивное умножение)
    mat_mul(BA, B, A, N);

    // 6) R = I - BA
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            R[i][j] = (i == j ? 1.0f : 0.0f) - BA[i][j];

    // 7) S = I + R + R^2 + ... + R^(M-1)
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
            S[i][j]  = (i == j) ? 1.0f : 0.0f;
            Rk[i][j] = R[i][j];
        }

    for (int k = 1; k < M; k++) {
        // S += Rk
        for (int i = 0; i < N; i++)
            for (int j = 0; j < N; j++)
                S[i][j] += Rk[i][j];

        // Rk = Rk * R
        mat_mul(tmp, Rk, R, N);

        // swap(Rk, tmp)
        float **t = Rk;
        Rk = tmp;
        tmp = t;
    }

    // 8) A^{-1} ≈ B * S
    mat_mul(tmp, B, S, N);

    auto end = clock_type::now();
    double seconds = std::chrono::duration<double>(end - start).count();

    printf("Готово (NAIVE)\n");
    printf("Время выполнения (NAIVE): %.6f секунд\n", seconds);

    // не обязательно, но красиво:
    free_matrix(A, N);
    free_matrix(AT, N);
    free_matrix(B, N);
    free_matrix(BA, N);
    free_matrix(R, N);
    free_matrix(Rk, N);
    free_matrix(S, N);
    free_matrix(tmp, N);

    return 0;
}
