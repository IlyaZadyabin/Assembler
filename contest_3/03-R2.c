#include <stdio.h>

int main(void)
{
    int a, b;
    char oper;
    scanf("%d %c %d", &a, &oper, &b);

    switch(oper)
    {
        case '*':
            printf("%d", a * b);
            break;
        case '/':
            printf("%d", a / b);
            break;
        case '-':
            printf("%d", a - b);
            break;
        case '+':
            printf("%d", a + b);
            break;
        default:
            break;
    }

}