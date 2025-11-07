	.file	"computerlab3.c"
	.text
	.globl	f
	.type	f, @function
f:
.LFB13:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	subl	$36, %esp
	fldl	8(%ebp)
	fstpl	(%esp)
	call	sin@PLT
	fstpl	-16(%ebp)
	fldl	8(%ebp)
	fstpl	(%esp)
	call	exp@PLT
	movl	-4(%ebp), %ebx
	fmull	-16(%ebp)
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE13:
	.size	f, .-f
	.globl	integral
	.type	integral, @function
integral:
.LFB14:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	.cfi_offset 6, -12
	call	__x86.get_pc_thunk.si
	addl	$_GLOBAL_OFFSET_TABLE_, %esi
	pushl	%ebx
	.cfi_offset 3, -16
	xorl	%ebx, %ebx
	subl	$48, %esp
	fldl	8(%ebp)
	fldl	16(%ebp)
	fsub	%st(1), %st
	fidivl	24(%ebp)
	fldz
.L4:
	cmpl	24(%ebp), %ebx
	jge	.L8
	fstpl	-48(%ebp)
	subl	$16, %esp
	movl	%ebx, -16(%ebp)
	fld	%st(0)
	fimull	-16(%ebp)
	incl	%ebx
	movl	%ebx, -16(%ebp)
	fadd	%st(2), %st
	fld	%st(1)
	fstpl	-40(%ebp)
	fxch	%st(1)
	fimull	-16(%ebp)
	fadd	%st(2), %st
	fxch	%st(2)
	fstpl	-32(%ebp)
	fxch	%st(1)
	fstpl	-24(%ebp)
	fstpl	(%esp)
	call	f
	fstpl	-16(%ebp)
	fldl	-24(%ebp)
	fstpl	(%esp)
	call	f
	faddl	-16(%ebp)
	addl	$16, %esp
	fmuls	.LC1@GOTOFF(%esi)
	fldl	-48(%ebp)
	faddp	%st, %st(1)
	fldl	-40(%ebp)
	fldl	-32(%ebp)
	fxch	%st(2)
	jmp	.L4
.L8:
	fstp	%st(2)
	fxch	%st(1)
	fmulp	%st, %st(1)
	leal	-8(%ebp), %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
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
	xorl	%eax, %eax
	leave
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE15:
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
.LFB16:
	.cfi_startproc
	movl	(%esp), %ebx
	ret
	.cfi_endproc
.LFE16:
	.section	.text.__x86.get_pc_thunk.si,"axG",@progbits,__x86.get_pc_thunk.si,comdat
	.globl	__x86.get_pc_thunk.si
	.hidden	__x86.get_pc_thunk.si
	.type	__x86.get_pc_thunk.si, @function
__x86.get_pc_thunk.si:
.LFB17:
	.cfi_startproc
	movl	(%esp), %esi
	ret
	.cfi_endproc
.LFE17:
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
