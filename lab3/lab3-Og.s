	.file	"computerlab3.c"
	.text
	.globl	f
	.type	f, @function
f:
.LFB23:
	.cfi_startproc
	endbr64
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movsd	%xmm0, 8(%rsp)
	call	sin@PLT
	movsd	%xmm0, (%rsp)
	movsd	8(%rsp), %xmm0
	call	exp@PLT
	mulsd	(%rsp), %xmm0
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	f, .-f
	.globl	integral
	.type	integral, @function
integral:
.LFB24:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$56, %rsp
	.cfi_def_cfa_offset 80
	movsd	%xmm0, 40(%rsp)
	movl	%edi, %ebp
	subsd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%edi, %xmm0
	divsd	%xmm0, %xmm1
	movsd	%xmm1, 32(%rsp)
	movl	$0, %ebx
	movq	$0x000000000, 8(%rsp)
	jmp	.L4
.L5:
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%ebx, %xmm0
	movsd	32(%rsp), %xmm2
	mulsd	%xmm2, %xmm0
	movsd	40(%rsp), %xmm3
	addsd	%xmm3, %xmm0
	addl	$1, %ebx
	pxor	%xmm1, %xmm1
	cvtsi2sdl	%ebx, %xmm1
	mulsd	%xmm2, %xmm1
	addsd	%xmm3, %xmm1
	movsd	%xmm1, 24(%rsp)
	call	f
	movsd	%xmm0, 16(%rsp)
	movsd	24(%rsp), %xmm0
	call	f
	addsd	16(%rsp), %xmm0
	mulsd	.LC1(%rip), %xmm0
	addsd	8(%rsp), %xmm0
	movsd	%xmm0, 8(%rsp)
.L4:
	cmpl	%ebp, %ebx
	jl	.L5
	movsd	8(%rsp), %xmm0
	mulsd	32(%rsp), %xmm0
	addq	$56, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	integral, .-integral
	.globl	main
	.type	main, @function
main:
.LFB25:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$150000000, %edi
	movsd	.LC2(%rip), %xmm1
	pxor	%xmm0, %xmm0
	call	integral
	movl	$0, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE25:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1071644672
	.align 8
.LC2:
	.long	1413754136
	.long	1074340347
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
