	.file	"computerlab3.c"
	.text
	.globl	f
	.type	f, @function
f:
.LFB13:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%xmm0, %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	call	sin@PLT
	movsd	%xmm0, 8(%rsp)
	movq	%rbx, %xmm0
	call	exp@PLT
	mulsd	8(%rsp), %xmm0
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE13:
	.size	f, .-f
	.globl	integral
	.type	integral, @function
integral:
.LFB14:
	.cfi_startproc
	endbr64
	subsd	%xmm0, %xmm1
	movaps	%xmm0, %xmm3
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	xorps	%xmm2, %xmm2
	cvtsi2sdl	%edi, %xmm0
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movl	%edi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	xorl	%ebx, %ebx
	divsd	%xmm0, %xmm1
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
.L4:
	cmpl	%ebp, %ebx
	jge	.L8
	cvtsi2sdl	%ebx, %xmm0
	incl	%ebx
	movsd	%xmm2, 24(%rsp)
	cvtsi2sdl	%ebx, %xmm4
	movsd	%xmm1, 16(%rsp)
	movsd	%xmm3, 8(%rsp)
	mulsd	%xmm1, %xmm0
	mulsd	%xmm1, %xmm4
	addsd	%xmm3, %xmm0
	addsd	%xmm3, %xmm4
	movq	%xmm4, %r14
	call	f
	movsd	%xmm0, (%rsp)
	movq	%r14, %xmm0
	call	f
	addsd	(%rsp), %xmm0
	mulsd	.LC1(%rip), %xmm0
	movsd	24(%rsp), %xmm2
	movsd	16(%rsp), %xmm1
	movsd	8(%rsp), %xmm3
	addsd	%xmm0, %xmm2
	jmp	.L4
.L8:
	mulsd	%xmm1, %xmm2
	addq	$32, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	movaps	%xmm2, %xmm0
	ret
	.cfi_endproc
.LFE14:
	.size	integral, .-integral
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB15:
	.cfi_startproc
	endbr64
	pushq	%rax
	.cfi_def_cfa_offset 16
	movsd	.LC2(%rip), %xmm1
	movl	$150000000, %edi
	xorps	%xmm0, %xmm0
	call	integral
	xorl	%eax, %eax
	popq	%rdx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE15:
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
