#include <stdio.h>
#include <math.h>

int main(void)
{
    unsigned int N, ans;
    int i;
    ans = 1;
    scanf("%u", &N);

    for(i = 0; i < N; i++)
    {
        ans *= 3;
    }
    printf("%u", ans);
}