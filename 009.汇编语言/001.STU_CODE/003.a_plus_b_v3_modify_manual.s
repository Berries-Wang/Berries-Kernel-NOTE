	.file	"003.a_plus_b_v3.c"
# GNU C (Ubuntu/Linaro 4.7.4-3ubuntu12) version 4.7.4 (x86_64-linux-gnu)
#	compiled by GNU C version 4.7.4, GMP version 6.1.0, MPFR version 3.1.3-p5, MPC version 1.0.3
# warning: GMP header version 6.1.0 differs from library version 6.2.0.
# warning: MPFR header version 3.1.3-p5 differs from library version 3.1.4.
# warning: MPC header version 1.0.3 differs from library version 1.1.0.
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed:  -imultilib . -imultiarch x86_64-linux-gnu
# 003.a_plus_b_v3.c -mtune=generic -march=x86-64 -fverbose-asm
# -fstack-protector
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
.LC0:
	.string	"a:%d , b:%d,result: %d \n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$32, %rsp	#,
	movl	%edi, -20(%rbp)	# argc, argc
	movq	%rsi, -32(%rbp)	# argv, argv
	movl	$0, -12(%rbp)	#, result
	movl	$1, -8(%rbp)	#, a
	movl	$1, -4(%rbp)	#, b
	movl	-4(%rbp), %edx	# b, tmp61
	movl	-8(%rbp), %eax	# a, tmp62
	movl	%edx, %esi	# tmp61,
	movl	%eax, %edi	# tmp62,
	call	add	#
	movl	%eax, -12(%rbp)	# tmp63, result
	movl	-12(%rbp), %ecx	# result, tmp64
	movl	-4(%rbp), %edx	# b, tmp65
	movl	-8(%rbp), %eax	# a, tmp66
	movl	%eax, %esi	# tmp66,
	movl	$.LC0, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
	movl	$0, %eax	#, D.2114
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.globl	add
	.type	add, @function
add:
.LFB1:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)	# a, a
	movl	%esi, -24(%rbp)	# b, b
	movl    $5,-24(%rbp)  # 手动修改的 修改变量b的值
	movl    $7, 44(%rbp)  # 手动修改的 修改main函数的b的值 ，本程序输出: a:1 , b:7,result: 6   (gcc 003.a_plus_b_v3_modify_manual.s  -o appgcc 003.a_plus_b_v3_modify_manual.s  -o app)
	movl	-24(%rbp), %eax	# b, tmp61
	movl	-20(%rbp), %edx	# a, tmp63
	addl	%edx, %eax	# tmp63, tmp62
	movl	%eax, -4(%rbp)	# tmp62, c
	movl	-4(%rbp), %eax	# c, D.2112
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	add, .-add
	.ident	"GCC: (Ubuntu/Linaro 4.7.4-3ubuntu12) 4.7.4"
	.section	.note.GNU-stack,"",@progbits
