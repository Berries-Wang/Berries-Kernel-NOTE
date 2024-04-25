# UNIX
Linux 内核源代码 & C
## Linux
内核知识学习

## C &U GNU C
GNU C 对C语言进行了拓展，具体请参考:[002.C&GNU_C](./002.C&GNU_C/).

如Redis，使用了GNU C拓展。
```c
   #ifndef _UINT32_T
   #define _UINT32_T
   typedef unsigned int uint32_t;
   #endif /* _UINT32_T */

   struct __attribute__ ((__packed__)) hisdshdr32 {
     uint32_t len; /* used */
     uint32_t alloc; /* excluding the header and null terminator */
     unsigned char flags; /* 3 lsb of type, 5 unused bits */
     char buf[];
   };
   // __attribute__ 为 GNU C 拓展
   // 更节约内存了，对于标准的C来说，存在对齐规则, 大小 4x bytes
   // 使用了 __attribute__ 之后，修改了标准C的对齐规则(按照一个字节对齐)，所以实际大小: 9 + n (n为buf长度) bytes

   // 测试代码: 004.TEST_CODE_SPACE/000.GNU_C__attribute__.c
```

## 参考资料
1. 《奔跑吧，Linux内核》
2. 《Linux内核的设计与实现》PTHREAD_STACK_MIN
3. [GNU C 手册](https://www.gnu.org/savannah-checkouts/gnu/c-intro-and-ref/manual/html_node/Symbol-Index.html)
