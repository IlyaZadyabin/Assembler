#include <stdio.h>

unsigned int count(unsigned int N, int K)
{
    unsigned int sum = 0, ans = 0;
    while(N)
    {
        sum += N%K;
        N /= K;
    }
    
    return sum;
}

int main(void)
{
    unsigned int N, ans, last;
    int K;
    scanf("%u %d", &N, &K);
    ans = N;

    last = count(N, K);

    while(last != N)
    {
        ans += last;
        N = last;
        last = count(N, K);
    }
    ans += last;

    printf("%u", ans);

}