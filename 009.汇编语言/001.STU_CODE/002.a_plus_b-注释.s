# Linux Berries-Wang 5.15.0-134-generic #145~20.04.1-Ubuntu SMP Mon Feb 17 13:27:16 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
	.file	"002.a_plus_b.c"
	.section	.rodata
.LC0: # 局部标签，表示常量数据
	.string	"result: %d \n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0: # 函数开始标签
	.cfi_startproc  # 标记一个 函数的开始，并为该函数生成 栈帧调试信息
	pushq	%rbp    # 入栈，将寄存器中的数据入栈,这里的含义： 调保存调用者的栈帧基址指针
	.cfi_def_cfa_offset 16 # 该指令表示当前的 规范帧地址（CFA） 是栈指针（%rsp 或 %esp）加上 16 字节后的地址。
	.cfi_offset 6, -16  # 指定某个寄存器在栈中的保存位置相对于 CFA（Canonical Frame Address）的偏移量
	movq	%rsp, %rbp  # 数据传送： %rbp -> %rsp,那此时 %rsp就是栈帧基址了
	.cfi_def_cfa_register 6 # 重新定义规范帧地址（Canonical Frame Address, CFA）的计算方式，改为通过指定的寄存器（这里是 6，即 %rbp）来计算 CFA，而不是默认的栈指针（%rsp）。
	subq	$32, %rsp   # 为局部变量分配空间,此处是分配32字节
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$0, -12(%rbp)  # 赋值 reslut $0 表示立即数‘0’
	movl	$1, -8(%rbp)   # 赋值a
	movl	$1, -4(%rbp)   # 赋值b
	movl	-4(%rbp), %edx
	movl	-8(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	add
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc # 标记函数结束，终止 CFI 数据
.LFE0: # 函数结束标签
	.size	main, .-main
	.globl	add
	.type	add, @function
add:
.LFB1:
	.cfi_startproc
	pushq	%rbp   # 入栈，将寄存器中的数据入栈
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-8(%rbp), %eax
	movl	-4(%rbp), %edx
	addl	%edx, %eax
	popq	%rbp  # 出栈，用寄存器接收出栈数据
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	add, .-add
	.ident	"GCC: (Ubuntu/Linaro 4.7.4-3ubuntu12) 4.7.4"
	.section	.note.GNU-stack,"",@progbits
