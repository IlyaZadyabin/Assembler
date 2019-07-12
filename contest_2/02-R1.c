#include <stdio.h>

int main(void)
{
    int N, i;
    unsigned int prev1, prev2, tmp;
    prev1 = 1;
    prev2 = 1;

    scanf("%d", &N);
    
    for(i = 2; i < N; i++)
    {
        tmp = prev2;
        prev2 = prev1 + prev2;
        prev1 = tmp;
    }

    printf("%u", prev2);
}