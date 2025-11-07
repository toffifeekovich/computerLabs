	.file	"computerlab3.c"
	.text
	.globl	f
	.type	f, @function
f:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$20, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	8(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -12(%ebp)
	subl	$8, %esp
	pushl	-12(%ebp)
	pushl	-16(%ebp)
	call	sin@PLT
	addl	$16, %esp
	fstpl	-24(%ebp)
	subl	$8, %esp
	pushl	-12(%ebp)
	pushl	-16(%ebp)
	call	exp@PLT
	addl	$16, %esp
	fmull	-24(%ebp)
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	f, .-f
	.globl	integral
	.type	integral, @function
integral:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$84, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	8(%ebp), %eax
	movl	%eax, -64(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -60(%ebp)
	movl	16(%ebp), %eax
	movl	%eax, -72(%ebp)
	movl	20(%ebp), %eax
	movl	%eax, -68(%ebp)
	fldl	-72(%ebp)
	fsubl	-64(%ebp)
	fildl	24(%ebp)
	fdivrp	%st, %st(1)
	fstpl	-32(%ebp)
	fldz
	fstpl	-40(%ebp)
	movl	$0, -44(%ebp)
	jmp	.L4
.L5:
	fildl	-44(%ebp)
	fmull	-32(%ebp)
	fldl	-64(%ebp)
	faddp	%st, %st(1)
	fstpl	-24(%ebp)
	movl	-44(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -80(%ebp)
	fildl	-80(%ebp)
	fmull	-32(%ebp)
	fldl	-64(%ebp)
	faddp	%st, %st(1)
	fstpl	-16(%ebp)
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-24(%ebp)
	call	f
	addl	$16, %esp
	fstpl	-80(%ebp)
	subl	$8, %esp
	pushl	-12(%ebp)
	pushl	-16(%ebp)
	call	f
	addl	$16, %esp
	fldl	-80(%ebp)
	faddp	%st, %st(1)
	fldl	.LC1@GOTOFF(%ebx)
	fdivrp	%st, %st(1)
	fldl	-40(%ebp)
	faddp	%st, %st(1)
	fstpl	-40(%ebp)
	addl	$1, -44(%ebp)
.L4:
	movl	24(%ebp), %eax
	cmpl	-44(%ebp), %eax
	jg	.L5
	fldl	-40(%ebp)
	fmull	-32(%ebp)
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	integral, .-integral
	.globl	main
	.type	main, @function
main:
.LFB2:
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
	subl	$36, %esp
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	fldz
	fstpl	-32(%ebp)
	fldl	.LC2@GOTOFF(%eax)
	fstpl	-24(%ebp)
	movl	$150000000, -36(%ebp)
	subl	$12, %esp
	pushl	-36(%ebp)
	pushl	-20(%ebp)
	pushl	-24(%ebp)
	pushl	-28(%ebp)
	pushl	-32(%ebp)
	call	integral
	addl	$32, %esp
	fstpl	-16(%ebp)
	movl	$0, %eax
	movl	-4(%ebp), %ecx
	.cfi_def_cfa 1, 0
	leave
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC1:
	.long	0
	.long	1073741824
	.align 8
.LC2:
	.long	1413754136
	.long	1074340347
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
.LFB3:
	.cfi_startproc
	movl	(%esp), %eax
	ret
	.cfi_endproc
.LFE3:
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
.LFB4:
	.cfi_startproc
	movl	(%esp), %ebx
	ret
	.cfi_endproc
.LFE4:
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
