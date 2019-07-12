#include <stdio.h>

int is_happy(unsigned int N, int K)
{
    unsigned int tmp = N, cnt, first_part, second_part;
    first_part = second_part = cnt = 0;
    int i;

    while(tmp != 0)
    {
        cnt++;
        tmp /= K;
    }

    if(cnt % 2) cnt++;

    tmp = N;
    for(i = 0; i < cnt; i++)
    {
        if(i < cnt/2)
            first_part += tmp % K;
        else
            second_part += tmp % K;

        tmp /= K;
    }

    if(first_part == second_part)
        return 1;
    else
        return 0;
    
}

int main(void)
{
    unsigned int N, i;
    int K;
    
    scanf("%u %d", &N, &K);

    for(i = N; ;i++)
    {
        if(is_happy(i, K))
        {
            printf("%u", i);
            return 0;
        }
    }
}