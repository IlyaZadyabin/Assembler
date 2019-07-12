#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int cnt;
    unsigned int x;

    FILE *f1;
    f1 = fopen("data.in", "r");

    fscanf (f1, "%u", &x);
    printf("%u", x);
    while(fscanf (f1, "%u", &x) == 1)
        cnt++;
    
    printf("%d", cnt);
    return 0;
}