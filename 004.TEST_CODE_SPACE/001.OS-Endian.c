#include <stdio.h>
#include <stdlib.h>

/**
 * 校验处理器是大端模式还是小端模式:
 * 联合体（union）的存放顺序是所有成员都从低地址开始存放
 */
void checkCPU(void) {
  union w {
    u_int64_t a;
    char b;
  } c;
  c.a = 1;
  if (c.b == 1) {
    printf("小端存储\n");
  } else {
    printf("小端存储\n");
  }
}

void checkCPU_V2(void) {
  union w {
    u_int64_t a;
    char b;
  } c;
  c.a = 0x12345678;
  if (c.b == 0x78) {
    printf("小端存储\n");
  } else {
    printf("小端存储\n");
  }
}

void checkCPU_V3(void) {
  u_int64_t *a = (u_int64_t *)malloc(sizeof(u_int64_t));
  *a = 0x12345678;
  char little_endian = ((char *)a)[3];
  if (little_endian == 0x12) {
    printf("小端存储\n");
  } else {
    printf("小端存储\n");
  }
}

int main(int argc, char **argv) {
  checkCPU();
  checkCPU_V2();
  checkCPU_V3();
  return 0;
}