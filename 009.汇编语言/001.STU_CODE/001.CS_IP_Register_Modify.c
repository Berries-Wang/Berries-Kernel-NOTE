#include <stdio.h>

int add_one(int value);

int main(int argc, char **argv)
{
    int result = 0;

    int (*ptr_add_one)(int) = add_one;

    result = ptr_add_one(7);

    printf("result: %d \n", result);

    return 0;
}

int add_one(int value)
{
    return value + 1;
}
