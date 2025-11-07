	.file	"computerlab3.c"
	.text
	.globl	f
	.type	f, @function
f:
.LFB23:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$40, %esp
	.cfi_def_cfa_offset 48
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	fldl	48(%esp)
	fstl	16(%esp)
	fstpl	(%esp)
	call	sin@PLT
	addl	$8, %esp
	.cfi_def_cfa_offset 40
	fstpl	16(%esp)
	pushl	12(%esp)
	.cfi_def_cfa_offset 44
	pushl	12(%esp)
	.cfi_def_cfa_offset 48
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
	subl	$48, %esp
	.cfi_def_cfa_offset 64
	call	__x86.get_pc_thunk.di
	addl	$_GLOBAL_OFFSET_TABLE_, %edi
	fldl	64(%esp)
	fstl	40(%esp)
	movl	80(%esp), %esi
	fsubrl	72(%esp)
	movl	%esi, 8(%esp)
	fildl	8(%esp)
	fdivrp	%st, %st(1)
	fstpl	32(%esp)
	testl	%esi, %esi
	jle	.L6
	movl	$0, %ebx
	fldz
	fstpl	8(%esp)
.L5:
	movl	%ebx, 16(%esp)
	fildl	16(%esp)
	fldl	32(%esp)
	fmul	%st, %st(1)
	fldl	40(%esp)
	fadd	%st, %st(2)
	addl	$1, %ebx
	movl	%ebx, 16(%esp)
	fildl	16(%esp)
	fmulp	%st, %st(2)
	faddp	%st, %st(1)
	fstpl	24(%esp)
	subl	$16, %esp
	.cfi_def_cfa_offset 80
	fstpl	(%esp)
	call	f
	fstpl	32(%esp)
	addl	$8, %esp
	.cfi_def_cfa_offset 72
	pushl	36(%esp)
	.cfi_def_cfa_offset 76
	pushl	36(%esp)
	.cfi_def_cfa_offset 80
	call	f
	faddl	32(%esp)
	fmuls	.LC1@GOTOFF(%edi)
	faddl	24(%esp)
	fstpl	24(%esp)
	addl	$16, %esp
	.cfi_def_cfa_offset 64
	cmpl	%esi, %ebx
	jne	.L5
.L4:
	fldl	32(%esp)
	fmull	8(%esp)
	addl	$48, %esp
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
	ret
.L6:
	.cfi_restore_state
	fldz
	fstpl	8(%esp)
	jmp	.L4
	.cfi_endproc
.LFE24:
	.size	integral, .-integral
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
	addl	$32, %esp
	movl	$0, %eax
	movl	-4(%ebp), %ecx
	.cfi_def_cfa 1, 0
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
.LFB26:
	.cfi_startproc
	movl	(%esp), %ebx
	ret
	.cfi_endproc
.LFE26:
	.section	.text.__x86.get_pc_thunk.di,"axG",@progbits,__x86.get_pc_thunk.di,comdat
	.globl	__x86.get_pc_thunk.di
	.hidden	__x86.get_pc_thunk.di
	.type	__x86.get_pc_thunk.di, @function
__x86.get_pc_thunk.di:
.LFB27:
	.cfi_startproc
	movl	(%esp), %edi
	ret
	.cfi_endproc
.LFE27:
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
