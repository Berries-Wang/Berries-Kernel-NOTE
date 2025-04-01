/**
*     // gcc -S  -fverbose-asm 002.a_plus_b.c 
*
*      #include <stdio.h>
*      // gcc -S  -fverbose-asm 002.a_plus_b.c 
*      int add(int a, int b);
*      
*      int main(int argc, char **argv)
*      {
*          int result = 0;
*      
*          int a = 1, b = 1;
*      
*          result = add(a, b);
*      
*          printf("result: %d \n", result);
*      
*          return 0;
*      }
*      
*      int add(int a, int b)
*      {
*          return a + b;
*      }
*      
*/
	.file	"002.a_plus_b.c"
# GNU C (Ubuntu/Linaro 4.7.4-3ubuntu12) version 4.7.4 (x86_64-linux-gnu)
#	compiled by GNU C version 4.7.4, GMP version 6.1.0, MPFR version 3.1.3-p5, MPC version 1.0.3
# warning: GMP header version 6.1.0 differs from library version 6.2.0.
# warning: MPFR header version 3.1.3-p5 differs from library version 3.1.4.
# warning: MPC header version 1.0.3 differs from library version 1.1.0.
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed:  -imultilib . -imultiarch x86_64-linux-gnu 002.a_plus_b.c
# -mtune=generic -march=x86-64 -fverbose-asm -fstack-protector
# options enabled:  -fasynchronous-unwind-tables -fauto-inc-dec
# -fbranch-count-reg -fcommon -fdebug-types-section
# -fdelete-null-pointer-checks -fdwarf2-cfi-asm -fearly-inlining
# -feliminate-unused-debug-types -ffunction-cse -fgcse-lm -fgnu-runtime
# -fident -finline-atomics -fira-share-save-slots -fira-share-spill-slots
# -fivopts -fkeep-static-consts -fleading-underscore -fmath-errno
# -fmerge-debug-strings -fmove-loop-invariants -fpeephole
# -fprefetch-loop-arrays -freg-struct-return
# -fsched-critical-path-heuristic -fsched-dep-count-heuristic
# -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
# -fsched-rank-heuristic -fsched-spec -fsched-spec-insn-heuristic
# -fsched-stalled-insns-dep -fshow-column -fsigned-zeros
# -fsplit-ivs-in-unroller -fstack-protector -fstrict-volatile-bitfields
# -ftrapping-math -ftree-coalesce-vars -ftree-cselim -ftree-forwprop
# -ftree-loop-if-convert -ftree-loop-im -ftree-loop-ivcanon
# -ftree-loop-optimize -ftree-parallelize-loops= -ftree-phiprop -ftree-pta
# -ftree-reassoc -ftree-scev-cprop -ftree-slp-vectorize
# -ftree-vect-loop-version -funit-at-a-time -funwind-tables
# -fvect-cost-model -fverbose-asm -fzero-initialized-in-bss
# -m128bit-long-double -m64 -m80387 -maccumulate-outgoing-args
# -malign-stringops -mfancy-math-387 -mfp-ret-in-387 -mglibc -mieee-fp
# -mmmx -mno-sse4 -mpush-args -mred-zone -msse -msse2 -mtls-direct-seg-refs

	.section	.rodata
.LC0: # 局部标签，表示常量数据
	.string	"result: %d \n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0: # 函数开始标签
	.cfi_startproc # 标记一个 函数的开始，并为该函数生成 栈帧调试信息
	pushq	%rbp	# 入栈，将寄存器中的数据入栈,这里的含义： 调保存调用者的栈帧基址指针
	.cfi_def_cfa_offset 16 # 该指令表示当前的 规范帧地址（CFA） 是栈指针（%rsp 或 %esp）加上 16 字节后的地址。
	.cfi_offset 6, -16 # 指定某个寄存器在栈中的保存位置相对于 CFA（Canonical Frame Address）的偏移量
	movq	%rsp, %rbp	#,   # 将栈顶指针(rsp)复制到rbp(当前函数的栈帧的基址)上,那就是保存被调用函数的基址
	.cfi_def_cfa_register 6  # 重新定义规范帧地址（Canonical Frame Address, CFA）的计算方式，改为通过指定的寄存器（这里是 6，即 %rbp）来计算 CFA，而不是默认的栈指针（%rsp）。
	subq	$32, %rsp	#,   # 为局部变量分配空间,此处是分配32字节
	movl	%edi, -20(%rbp)	# argc, argc  # x86-64 参数传递：%rdi, %rsi, %rdx, %rcx, %r8, %r9 用作函数参数，依次对应第1个参数，第2个参数 (x86-64最多可以用 6 个寄存器传递参数，参数多于 6 个时，使用栈传递参)
	movq	%rsi, -32(%rbp)	# argv, argv  # x86-64 参数传递
	movl	$0, -12(%rbp)	#, result 
	movl	$1, -8(%rbp)	#, a
	movl	$1, -4(%rbp)	#, b
	movl	-4(%rbp), %edx	# b, tmp61
	movl	-8(%rbp), %eax	# a, tmp62
	movl	%edx, %esi	# tmp61,
	movl	%eax, %edi	# tmp62,
	call	add	#
	movl	%eax, -12(%rbp)	# tmp63, result
	movl	-12(%rbp), %eax	# result, tmp64
	movl	%eax, %esi	# tmp64,
	movl	$.LC0, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
	movl	$0, %eax	#, D.2113
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:  # 函数结束标签
	.size	main, .-main
	.globl	add
	.type	add, @function
add:
.LFB1:
	.cfi_startproc
	pushq	%rbp	# # 入栈，将寄存器中的数据入栈
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)	# a, a
	movl	%esi, -8(%rbp)	# b, b
	movl	-8(%rbp), %eax	# b, tmp61
	movl	-4(%rbp), %edx	# a, tmp62
	addl	%edx, %eax	# tmp62, D.2111 # 做加法 addl %ebx, %eax  # eax = eax + ebx
	popq	%rbp	# 将调用者栈基址出栈，即恢复调用者的栈帧
	.cfi_def_cfa 7, 8
	ret  # 返回到调用者
	.cfi_endproc
.LFE1:
	.size	add, .-add
	.ident	"GCC: (Ubuntu/Linaro 4.7.4-3ubuntu12) 4.7.4"
	.section	.note.GNU-stack,"",@progbits
