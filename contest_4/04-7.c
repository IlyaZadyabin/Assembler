#include <stdio.h>
#include <string.h>

int main(void)
{
    int N, i;
    char a[500][11];
    scanf("%d", &N);

    for(i = 0; i < N; i++)
    {
        scanf("%s", a[i]);
    }
    for(i = 0; i < N; i++)
    {
        printf("%s", a[i]);
    }
}
