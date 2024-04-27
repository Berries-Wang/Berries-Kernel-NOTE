#include <stdio.h>

#ifndef _UINT32_T
#define _UINT32_T
typedef unsigned int uint32_t;
#endif /* _UINT32_T */

struct __attribute__((__packed__)) hisdshdr32 {
  uint32_t len;        /* used */
  uint32_t alloc;      /* excluding the header and null terminator */
  unsigned char flags; /* 3 lsb of type, 5 unused bits */
  char buf[];
};

struct hisdshdr32_no {
  uint32_t len;        /* used */
  uint32_t alloc;      /* excluding the header and null terminator */
  unsigned char flags; /* 3 lsb of type, 5 unused bits */
  char buf[];
};

int main(int argc, char **argv) {
  printf("%ld \n", sizeof(struct hisdshdr32)); // 9
  printf("%ld \n", sizeof(struct hisdshdr32_no)); // 12

  return 0;
}
