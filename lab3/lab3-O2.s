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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	subsd	%xmm0, %xmm1
	movapd	%xmm0, %xmm2
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$72, %rsp
	.cfi_def_cfa_offset 96
	movsd	%xmm0, 56(%rsp)
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%edi, %xmm0
	divsd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	mulsd	%xmm1, %xmm0
	movsd	%xmm1, 48(%rsp)
	testl	%edi, %edi
	jle	.L7
	addsd	%xmm2, %xmm0
	movl	%edi, %ebx
	xorl	%ebp, %ebp
	call	sin@PLT
	pxor	%xmm2, %xmm2
	movsd	%xmm0, 8(%rsp)
	movapd	%xmm2, %xmm1
	.p2align 4,,10
	.p2align 3
.L6:
	movsd	48(%rsp), %xmm4
	addl	$1, %ebp
	movsd	56(%rsp), %xmm5
	movsd	%xmm2, 40(%rsp)
	mulsd	%xmm4, %xmm1
	movapd	%xmm1, %xmm3
	pxor	%xmm1, %xmm1
	cvtsi2sdl	%ebp, %xmm1
	addsd	%xmm5, %xmm3
	mulsd	%xmm1, %xmm4
	movsd	%xmm1, 32(%rsp)
	movapd	%xmm4, %xmm0
	addsd	%xmm5, %xmm0
	movsd	%xmm0, 16(%rsp)
	movapd	%xmm3, %xmm0
	call	exp@PLT
	movsd	8(%rsp), %xmm6
	mulsd	%xmm0, %xmm6
	movsd	16(%rsp), %xmm0
	movsd	%xmm6, 24(%rsp)
	call	sin@PLT
	movsd	%xmm0, 8(%rsp)
	movsd	16(%rsp), %xmm0
	call	exp@PLT
	mulsd	8(%rsp), %xmm0
	cmpl	%ebx, %ebp
	movsd	40(%rsp), %xmm2
	addsd	24(%rsp), %xmm0
	mulsd	.LC1(%rip), %xmm0
	movsd	32(%rsp), %xmm1
	addsd	%xmm0, %xmm2
	jne	.L6
.L5:
	movsd	48(%rsp), %xmm0
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	mulsd	%xmm2, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	.cfi_restore_state
	pxor	%xmm2, %xmm2
	jmp	.L5
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
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movsd	.LC2(%rip), %xmm1
	movl	$150000000, %edi
	pxor	%xmm0, %xmm0
	call	integral
	xorl	%eax, %eax
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
