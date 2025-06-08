# 进程调度
> 先学习: [arm:Simplistic interrupt handling](../999.REFS/ARM%20Cortex-A%20(ARMv7-A)%20Series%20Programmer's%20Guide.pdf) & [硬件如何在多任务处理时辅助软件？ | 多进程 | 硬件中断 | 上下文切换](../../010.LESSONS/28434237523-1-192.mp4)

>> 需要关联[https://github.com/Berries-Wang/Berries-Kernel](https://github.com/Berries-Wang/Berries-Kernel)一同学习

__schedule()是调度器的核心函数，其作用是让调度器选择和切换到一个合适进程并运行。`调度的时机`可以分为如下3种。
+ 在阻塞操作中，如使用互斥量（mutex）、信号量（semaphore）、等待队列（waitqueue）等。
+ 在中断返回前和系统调用返回用户空间时，检查TIF_NEED_RESCHED标志位以判断是否需要调度。
+ 将要被唤醒的进程不会马上调用schedule()，而是会被添加到CFS就绪队列中，并且设置了TIF_NEED_RESCHED标志位。

那么被唤醒的进程`什么时候被调度`呢？这要根据内核是否具有可抢占功能（CONFIG_PREEMPT=y）分两种情况。
+ 如果内核可抢占，则根据情况执行不同操作。
   - 如果唤醒动作发生在系统调用或者异常处理上下文中，在下一次调用preempt_enable()时会检查是否需要抢占调度。
   - 如果唤醒动作发生在硬中断处理上下文中，硬件中断处理返回前会检查是否要抢占当前进程。
+ 如果内核不可抢占，则执行以下操作。
   - 当前进程调用cond_resched()时会检查是否要调度。
   - 主动调用schedule()。

---

通过学习资料可以发现:
- 在执行context-switch时，没必要复制所有的寄存器，只需要为 栈指针&程序计数器 设置一个单独的集合(用户态一个&内核态一个)，其他寄存器由软件来复制.
- 硬件如何辅助 Context-Switch

---

## user-mode & kernel-mode
”mode-switch“ 是一个运行的task从user-mode 切换到 kernel-mode，或者切换回来， 而 ”context-swtich“ 一定发生在kernel-mode , 进行task切换

每个user task 有一个user-mode stack 和 一个 kernel-mode stack ， 当从 user-mode 切换到 kernel-mode 时，寄存器的值要保存到 kernel-mode stack 。 反之，从kernel-mode切换回user-mode时，需要把寄存器中的值恢复出来。

进行 ”context-switch“ 时，scheduler 将当前kernel-mode stack 中的值保存在task_struct中，并把下一个将要运行的task的task_struct值恢复到kernel-mode stack中。这样，从kernel-mode 返回 到 user-mode , 就会运行另外一个task

### 疑问
关于user-mode 和 kernel-mode ,学习[CPU 内核/用户操作模式 ｜ 处理器中的单个比特如何保护操作系统的安全完整性](../../010.LESSONS/26436437797-1-16.mp4) & [001.UNIX-DOCS/005.syscall-发起系统调用.md](001.UNIX-DOCS/005.syscall-发起系统调用.md)#`系统调用时寄存器&CPU状态如何存储到task_struct中`<sub>因为只有PC CPU状态的保存，而并没有task_struct的切换，就直接进入了内核态执行系统调用</sub> (位于:[Berries-Kernel](https://github.com/Berries-Wang/Berries-Kernel)仓库下),可以发现，并不存在内核线程。切换到内核态，即将执行权限交还给OS，使得能够访问硬件资源，内核态是运行在当前进程的task_struct中的。

##### user-mode 如何切换到 kernel-mode，需要执行哪些操作?(主要是寄存器怎么迁移的)
user-mode 切换为 kernel-mode , 会保存user-mode下的PC寄存器以及CPU状态，详见:[001.UNIX-DOCS/005.syscall-发起系统调用.md](001.UNIX-DOCS/005.syscall-发起系统调用.md) (位于:[Berries-Kernel](https://github.com/Berries-Wang/Berries-Kernel)仓库下<sup>由svc引发的软中断</sup>)


##### kernel-mode 如何切换到 user-mode，需要执行哪些操作?(主要是寄存器怎么迁移的)


---

## 参考资料
+ [奔跑吧Linux内核 # 8.1.5　进程调度](../../006.BOOKs/Run%20Linux%20Kernel%20(2nd%20Edition)%20Volume%201:%20Infrastructure.epub)
+ [StackOverflow： Context switch internals](../999.REFS/Linux-Kernel-Context_switch_internals-Stack-Overflow.pdf)
+ [arm.community: Use case of MSP and PSP in Cortex M](../999.REFS/Use%20case%20of%20MSP%20and%20PSP%20in%20Cortex%20M%20Arm-Community.pdf)
+ [arm:硬件辅助中断](../999.REFS/DEN0013D_cortex_a_series_PG.pdf)
  - [arm: Simplistic-interrupt-handling](https://developer.arm.com/documentation/den0013/d/Interrupt-Handling/External-interrupt-requests/Simplistic-interrupt-handling?lang=en)
  - [Arm: Simplistic interrupt handling](../999.REFS/ARM%20Cortex-A%20(ARMv7-A)%20Series%20Programmer's%20Guide.pdf)
