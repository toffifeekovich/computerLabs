#include <cblas.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <chrono>

#define MAT(m,i,j,N) m[(i)*(N) + (j)]

// Норма по строкам
float norm_inf(const float* A, int N) {
    float m = 0.0f;
    for (int i = 0; i < N; i++) {
        float s = 0;
        for (int j = 0; j < N; j++)
            s += fabsf(A[i * N + j]);
        if (s > m) m = s;
    }
    return m;
}

int main() {
    int N = 2048;
    int M = 10;

    // Массивы N*N
    float *A   = (float*)malloc(N * N * sizeof(float));
    float *AT  = (float*)malloc(N * N * sizeof(float));
    float *B   = (float*)malloc(N * N * sizeof(float));
    float *BA  = (float*)malloc(N * N * sizeof(float));
    float *R   = (float*)malloc(N * N * sizeof(float));
    float *Rk  = (float*)malloc(N * N * sizeof(float));
    float *S   = (float*)malloc(N * N * sizeof(float));
    float *TMP = (float*)malloc(N * N * sizeof(float));

    if (!A || !AT || !B || !BA || !R || !Rk || !S || !TMP) {
        printf("Memory allocation failed\n");
        return 1;
    }

    srand(0);

    //  ТАЙМЕР НАЧАЛО 
    auto t0 = std::chrono::high_resolution_clock::now();

    // 1) A — случайная
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            MAT(A,i,j,N) = float(rand()%10 + 1);

    // 2) AT = A^T
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            MAT(AT,i,j,N) = MAT(A,j,i,N);

    // 3) Нормы
    float na  = norm_inf(A,  N);
    float nat = norm_inf(AT, N);
    float alpha = na * nat;

    // 4) B = AT / alpha
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            MAT(B,i,j,N) = MAT(AT,i,j,N) / alpha;

    // 5) BA = B * A         BLAS
    cblas_sgemm(
        CblasRowMajor, CblasNoTrans, CblasNoTrans,
        N, N, N,
        1.0f,
        B,  N,
        A,  N,
        0.0f,
        BA, N
    );
    /*
CblasRowMajor -Матрицы лежат в памяти по строкам (A[i*N + j]).

CblasNoTrans, CblasNoTrans
Ничего не транспонируем: op(B)=B, op(A)=A.

N, N, N
Это размеры:

M = N (строки результата)

N = N (столбцы результата)

K = N (общая внутренняя размерность)

1.0f — это alpha из формулы BLAS 

B, N — матрица B и её leading dimension (шаг по строке).
При RowMajor это обычно просто N.

A, N — матрица A

0.0f — beta (значит старое содержимое BA не учитываем)

BA, N — куда писать результат
    */

    // 6) R = I - BA
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            MAT(R,i,j,N) = (i == j ? 1.0f : 0.0f) - MAT(BA,i,j,N);

    // 7) S = I + R + R^2 + ... + R^(M-1)
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
            MAT(S,i,j,N)  = (i == j);
            MAT(Rk,i,j,N) = MAT(R,i,j,N);
        }

    for (int iter = 1; iter < M; iter++) {
        // S += Rk
        for (int i = 0; i < N; i++)
            for (int j = 0; j < N; j++)
                MAT(S,i,j,N) += MAT(Rk,i,j,N);

        // TMP = Rk * R    ✔️ BLAS
        cblas_sgemm(
            CblasRowMajor, CblasNoTrans, CblasNoTrans,
            N, N, N,
            1.0f,
            Rk, N,
            R,  N,
            0.0f,
            TMP, N
        );

        // swap(Rk, TMP)
        float *t = Rk;
        Rk = TMP;
        TMP = t;
    }

    // 8) A^{-1} ≈ B * S    BLAS
    cblas_sgemm(
        CblasRowMajor, CblasNoTrans, CblasNoTrans,
        N, N, N,
        1.0f,
        B,  N,
        S,  N,
        0.0f,
        TMP, N    // результат (приближённая inverse)
    );

    //  ТАЙМЕР КОНЕЦ
    auto t1 = std::chrono::high_resolution_clock::now();
    double seconds = std::chrono::duration<double>(t1 - t0).count();

    printf("Готово (BLAS)\n");
    printf("Время выполнения (BLAS): %.6f сек\n", seconds);

    // освобождение
    free(A); free(AT); free(B); free(BA);
    free(R); free(Rk); free(S); free(TMP);

    return 0;
}
//g++ computerlab7-3.cpp -O3 -march=native -ffast-math -lopenblas -o lab7_blas
/*
матрицы хранятся как один плоский массив float* (не float**)
умножение C = A*B выполняет OpenBLAS/BLAS, внутри там SIMD + блокирование + работа с кэшем + часто многопоточность
*/