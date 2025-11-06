#include <stdio.h>
#include <math.h>


#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif


double f(double x)
{
    return sin(x) * exp(x);
}

double integral(double a, double b, int N)
{
    double h = (b - a) / N;
    double  sum = 0;
    for (int k = 0; k <= N - 1; k++)
    {
        double xk = a + k * h;
        double xk1 = a + (k + 1) * h;

        sum += (f(xk) + f(xk1)) / 2;
    }
    return sum * h;
}

int main()
{
    double a = 0;
    double b = M_PI;
    int N = 15e7;

    double answer = integral(a, b, N);

    return 0;
}
