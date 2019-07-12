#include <stdio.h>

int main(void)
{
    int i, x1, x2, y1, y2, x, y, tmp, xp, yp;
    x1 = x2 = y1 = y2 = 2000;

    scanf("%d %d", &x1, &y1);

    for(i = 0; i < 3; i++)
    {
        scanf("%d %d", &x, &y);
        if(x != x1) x2 = x;
        if(y != y1) y2 = y;
    }

    if(x2 < x1)
    {
        tmp = x1;
        x1 = x2;
        x2 = tmp;
    }

    if(y2 < y1)
    {
        tmp = y1;
        y1 = y2;
        y2 = tmp;
    }

    scanf("%d %d", &xp, &yp);
    if((xp < x2) && (xp > x1) && (yp < y2) && (yp > y1))
        printf("YES");
    else
        printf("NO");
}