u#include <stdio.h>

int incomplete(unsigned int N)
{
    unsigned int sum = 0, i;

    for(i = 1; i < N; i++)
        if(N%i == 0)
            sum += i;

    if(sum < N)
        return 1;
    else
        return 0;
}

int main(void)
{
    unsigned int N;
    int K, i, cnt = 0;
    scanf("%d", &K);

    for(i = 1; cnt < K; i++)
    {
        cnt += incomplete(i);
        printf("incomplete(%d) = %d\n", i, incomplete(i));
    }
    printf("%d", i-1);
}