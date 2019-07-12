#include <stdio.h>

int main(void)
{
    int N, M, K, i, j, k;
    scanf("%d %d %d", &N, &M, &K);
    int a[10000], b[10000], c[10000];

    for(i = 0; i < N*M; i++)
        scanf("%d", &a[i]);

    for(i = 0; i < M*K; i++)
        scanf("%d", &b[i]);

    for(i = 0; i < N; i++)
        for(j = 0; j < K; j++)
            for(k = 0; k < M; k++)
                c[i*K + j] += a[i*M + k] * b[j + k*K];

    for(i = 0; i < N; i++)
    {
        for(j = 0; j < K; j++)
            printf("%d ", c[i*K + j]);
        printf("\n");
    }
}