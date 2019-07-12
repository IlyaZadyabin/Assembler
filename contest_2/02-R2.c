#include <stdio.h>

int main(void)
{
    unsigned int a, b;
    scanf("%u", &a);

    b = a;
    b--;
    a ^= b;
    a++;

    if(a == 0)
        printf("%u", 1 << 31);
    else
        printf("%u", a>>1);
}