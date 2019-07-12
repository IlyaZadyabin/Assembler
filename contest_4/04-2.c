#include <stdio.h>
#include <string.h>

int main(void)
{
    char *a = "pointer";
    char *b = "stack_pointer";

    printf("%s\n", strstr(b, a));
}