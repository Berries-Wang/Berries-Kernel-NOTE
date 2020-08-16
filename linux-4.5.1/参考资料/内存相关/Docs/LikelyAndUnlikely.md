# likely和unlikely
参考/include/linux/compiler.h */
+ # define likely(x)  __builtin_expect(!!(x), 1)
+ # define unlikely(x)    __builtin_expect(!!(x), 0)

　　上述源码中采用了内建函数__builtin_expect来进行定义，即 built in function。
　　__builtin_expect的函数原型为long __builtin_expect (long exp, long c)，返回值为完整表达式exp的值，它的作用是期望表达式exp的值等于c（如果exp == c条件成立的机会占绝大多数，那么性能将会得到提升，否则性能反而会下降）。注意， __builtin_expect (lexp, c)的返回值仍是exp值本身，并不会改变exp的值。
　　__builtin_expect函数用来引导gcc进行条件分支预测。在一条指令执行时，由于流水线的作用，CPU可以同时完成下一条指令的取指，这样可以提高CPU的利用率。在执行条件分支指令时，CPU也会预取下一条执行，但是如果条件分支的结果为跳转到了其他指令，那CPU预取的下一条指令就没用了，这样就降低了流水线的效率。
　　另外，跳转指令相对于顺序执行的指令会多消耗CPU时间，如果可以尽可能不执行跳转，也可以提高CPU性能。
　　简单从表面上看if(likely(value)) == if(value)，if(unlikely(value)) == if(value)。
**也就是likely和unlikely是一样的**，但是实际上执行是不同的，加likely的意思是value的值为真的可能性更大一些，那么执行if的机会大，而unlikely表示value的值为假的可能性大一些，执行else机会大一些。
　　**加上这种修饰，编译成二进制代码时likely使得if后面的执行语句紧跟着前面的程序，unlikely使得else后面的语句紧跟着前面的程序，这样就会被cache预读取，增加程序的执行速度。**
　　那么上述定义中为什么要使用！！符号呢？
　　计算机中bool逻辑只有0和1，非0即是1，当likely(x)中参数不是逻辑值时，就可以使用！！符号转化为逻辑值1或0 。比如：！！（3）=！（！（3））=！0=1，这样就把参数3转化为逻辑1了。
　　那么简单理解就是：
　　likely(x)代表x是逻辑真（1）的可能性比较大；
　　unlikely(x)代表x是逻辑假（0）的可能性比较大。