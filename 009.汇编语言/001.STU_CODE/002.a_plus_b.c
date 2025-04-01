#include <stdio.h>
// gcc -S  -fverbose-asm 002.a_plus_b.c 
int add(int a, int b);

int main(int argc, char **argv)
{
    int result = 0;

    int a = 1, b = 1;

    result = add(a, b);

    printf("result: %d \n", result);

    return 0;
}

int add(int a, int b)
{
    return a + b;
}
