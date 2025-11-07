	.file	"computerlab3.c"
	.text
	.p2align 4
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
	movsd	8(%rsp), %xmm1
	movsd	%xmm0, (%rsp)
	movapd	%xmm1, %xmm0
	call	exp@PLT
	mulsd	(%rsp), %xmm0
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	f, .-f
	.p2align 4
	.globl	integral
	.type	integral, @function
integral:
.LFB24:
	.cfi_startproc
	endbr64
	subsd	%xmm0, %xmm1
	movapd	%xmm0, %xmm7
	pxor	%xmm0, %xmm0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	cvtsi2sdl	%edi, %xmm0
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$56, %rsp
	.cfi_def_cfa_offset 80
	divsd	%xmm0, %xmm1
	movsd	%xmm1, 32(%rsp)
	testl	%edi, %edi
	jle	.L7
	movapd	%xmm7, %xmm0
	movl	%edi, %ebx
	movsd	%xmm7, 40(%rsp)
	xorl	%ebp, %ebp
	call	sin@PLT
	movsd	%xmm0, (%rsp)
	movsd	40(%rsp), %xmm0
	call	exp@PLT
	movsd	(%rsp), %xmm3
	pxor	%xmm4, %xmm4
	mulsd	%xmm0, %xmm3
	.p2align 4,,10
	.p2align 3
.L6:
	addl	$1, %ebp
	pxor	%xmm1, %xmm1
	movsd	%xmm4, 24(%rsp)
	cvtsi2sdl	%ebp, %xmm1
	mulsd	32(%rsp), %xmm1
	movsd	%xmm3, 16(%rsp)
	addsd	40(%rsp), %xmm1
	movapd	%xmm1, %xmm0
	movsd	%xmm1, 8(%rsp)
	call	sin@PLT
	movsd	8(%rsp), %xmm1
	movsd	%xmm0, (%rsp)
	movapd	%xmm1, %xmm0
	call	exp@PLT
	movsd	(%rsp), %xmm3
	movsd	16(%rsp), %xmm2
	movsd	24(%rsp), %xmm4
	mulsd	%xmm0, %xmm3
	movsd	.LC1(%rip), %xmm0
	addsd	%xmm3, %xmm2
	mulsd	%xmm2, %xmm0
	addsd	%xmm0, %xmm4
	cmpl	%ebx, %ebp
	jne	.L6
	movsd	32(%rsp), %xmm0
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	mulsd	%xmm4, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	.cfi_restore_state
	addq	$56, %rsp
	.cfi_def_cfa_offset 24
	pxor	%xmm0, %xmm0
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	integral, .-integral
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB25:
	.cfi_startproc
	endbr64
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE25:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1071644672
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
