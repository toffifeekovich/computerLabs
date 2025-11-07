	.file	"computerlab3.c"
	.text
	.p2align 4
	.globl	f
	.type	f, @function
f:
.LFB23:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	subl	$40, %esp
	.cfi_def_cfa_offset 48
	fldl	48(%esp)
	fstl	(%esp)
	fstpl	48(%esp)
	call	sin@PLT
	fstpl	24(%esp)
	fldl	48(%esp)
	fstpl	(%esp)
	call	exp@PLT
	fmull	24(%esp)
	addl	$40, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
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
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	subl	$64, %esp
	.cfi_def_cfa_offset 80
	fldl	80(%esp)
	movl	96(%esp), %edi
	movl	%edi, 8(%esp)
	fstl	56(%esp)
	fldl	88(%esp)
	fsub	%st(1), %st
	fildl	8(%esp)
	fdivrp	%st, %st(1)
	fstl	48(%esp)
	fldz
	fmulp	%st, %st(1)
	testl	%edi, %edi
	jle	.L7
	faddp	%st, %st(1)
	subl	$16, %esp
	.cfi_def_cfa_offset 96
	xorl	%esi, %esi
	fstpl	(%esp)
	call	sin@PLT
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	fstpl	8(%esp)
	fldz
	fld	%st(0)
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L10:
	fxch	%st(1)
.L6:
	fstpl	40(%esp)
	fldl	48(%esp)
	addl	$1, %esi
	subl	$16, %esp
	.cfi_def_cfa_offset 96
	movl	%esi, 32(%esp)
	fmul	%st, %st(1)
	fldl	72(%esp)
	fadd	%st, %st(2)
	fildl	32(%esp)
	fmul	%st, %st(2)
	fstpl	48(%esp)
	faddp	%st, %st(1)
	fstpl	32(%esp)
	fstpl	(%esp)
	call	exp@PLT
	fmull	24(%esp)
	fstpl	40(%esp)
	popl	%eax
	.cfi_def_cfa_offset 92
	popl	%edx
	.cfi_def_cfa_offset 88
	pushl	28(%esp)
	.cfi_def_cfa_offset 92
	pushl	28(%esp)
	.cfi_def_cfa_offset 96
	call	sin@PLT
	popl	%ecx
	.cfi_def_cfa_offset 92
	popl	%eax
	.cfi_def_cfa_offset 88
	fstpl	16(%esp)
	pushl	28(%esp)
	.cfi_def_cfa_offset 92
	pushl	28(%esp)
	.cfi_def_cfa_offset 96
	call	exp@PLT
	fmull	24(%esp)
	faddl	40(%esp)
	fmuls	.LC1@GOTOFF(%ebx)
	fldl	56(%esp)
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	cmpl	%edi, %esi
	faddp	%st, %st(1)
	fldl	32(%esp)
	jne	.L10
	fstp	%st(0)
	fldl	48(%esp)
	addl	$64, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	fmulp	%st, %st(1)
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	.cfi_restore_state
	fstp	%st(0)
	fstp	%st(0)
	fldz
	fldl	48(%esp)
	addl	$64, %esp
	.cfi_def_cfa_offset 16
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	fmulp	%st, %st(1)
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
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x7c,0x6
	subl	$16, %esp
	pushl	$150000000
	pushl	$1074340347
	pushl	$1413754136
	pushl	$0
	pushl	$0
	call	integral
	fstp	%st(0)
	movl	-4(%ebp), %ecx
	.cfi_def_cfa 1, 0
	addl	$32, %esp
	xorl	%eax, %eax
	leave
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE25:
	.size	main, .-main
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC1:
	.long	1056964608
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
.LFB27:
	.cfi_startproc
	movl	(%esp), %ebx
	ret
	.cfi_endproc
.LFE27:
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
