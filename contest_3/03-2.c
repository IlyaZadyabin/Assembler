#include <stdio.h>

unsigned int rec(unsigned int num)
{
    if(num)
        return (num%3)%2 + rec(num/3);
    return 0;
}

int main(void)
{
    unsigned int N;
    scanf("%u", &N);
    printf("%u", rec(N));
}