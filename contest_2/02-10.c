#include <stdio.h>

int main(void)
{
    int N, i, max = 0;
    scanf("%d", &N);

    for(i = N-1; i >= 1; i--)
    {
        if((N % i == 0) && (i > max))
            max = i;
    }
    printf("%d", max);
}