#include <stdio.h>

unsigned int rec(unsigned int N)
{
    if(N == 0)
        return 1;
    N--;
    return 3*rec(N);
}

int main(void)
{
    unsigned int N;
    scanf("%u", &N);
    printf("%u", rec(N));
}

