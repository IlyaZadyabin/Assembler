#include <stdio.h>

int gcd(int a, int b)
{
    while ((a != 0) && (b != 0))
    {
        if (a > b)
            a = a % b;
        else
            b = b % a;
    }
    return a + b;
}
int main(void)
{
    int a, b, i;
    scanf("%d", &a);

    for(i = 0; i < 3; i++)
    {
        scanf("%d", &b);
        a = gcd(a, b);
    }
    printf("%d", a);
}
