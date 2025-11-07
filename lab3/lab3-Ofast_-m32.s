	.file	"computerlab3.c"
	.text
	.p2align 4
	.globl	f
	.type	f, @function
f:
.LFB23:
	.cfi_startproc
	subl	$20, %esp
	.cfi_def_cfa_offset 24
	fldl	24(%esp)
	fld	%st(0)
	fsin
	fldl2e
	fld	%st(0)
	fstpt	(%esp)
	addl	$20, %esp
	.cfi_def_cfa_offset 4
	fld1
	fxch	%st(3)
	fmulp	%st, %st(1)
	fld	%st(0)
	frndint
	fsubr	%st, %st(1)
	fxch	%st(1)
	f2xm1
	faddp	%st, %st(3)
	fxch	%st(1)
	fxch	%st(2)
	fscale
	fstp	%st(1)
	fmulp	%st, %st(1)
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
	call	__x86.get_pc_thunk.dx
	addl	$_GLOBAL_OFFSET_TABLE_, %edx
	subl	$12, %esp
	.cfi_def_cfa_offset 16
	fldl	16(%esp)
	fldl	24(%esp)
	movl	32(%esp), %ecx
	fsub	%st(1), %st
	movl	%ecx, 4(%esp)
	fildl	4(%esp)
	fdivrp	%st, %st(1)
	testl	%ecx, %ecx
	jle	.L7
	fld	%st(1)
	xorl	%eax, %eax
	fld	%st(0)
	fsin
	fldl2e
	fmul	%st, %st(2)
	fld	%st(2)
	frndint
	fsubr	%st, %st(3)
	fxch	%st(3)
	f2xm1
	fadds	.LC1@GOTOFF(%edx)
	fxch	%st(1)
	fxch	%st(3)
	fxch	%st(1)
	fscale
	fstp	%st(1)
	fldz
	fxch	%st(2)
	fmulp	%st, %st(1)
	.p2align 4,,10
	.p2align 3
.L6:
	addl	$1, %eax
	movl	%eax, 4(%esp)
	fildl	4(%esp)
	fmul	%st(4), %st
	fadd	%st(5), %st
	fld	%st(0)
	fsin
	fxch	%st(1)
	fmul	%st(4), %st
	fld	%st(0)
	frndint
	fsubr	%st, %st(1)
	fxch	%st(1)
	f2xm1
	fadds	.LC1@GOTOFF(%edx)
	fscale
	fstp	%st(1)
	fmulp	%st, %st(1)
	fadd	%st, %st(1)
	fxch	%st(1)
	fmuls	.LC3@GOTOFF(%edx)
	faddp	%st, %st(2)
	cmpl	%ecx, %eax
	jne	.L6
	fstp	%st(0)
	fstp	%st(3)
	fstp	%st(0)
	fxch	%st(1)
	fmulp	%st, %st(1)
	addl	$12, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	.cfi_restore_state
	fstp	%st(0)
	fstp	%st(0)
	fldz
	addl	$12, %esp
	.cfi_def_cfa_offset 4
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
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE25:
	.size	main, .-main
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC1:
	.long	1065353216
	.align 4
.LC3:
	.long	1056964608
	.section	.text.__x86.get_pc_thunk.dx,"axG",@progbits,__x86.get_pc_thunk.dx,comdat
	.globl	__x86.get_pc_thunk.dx
	.hidden	__x86.get_pc_thunk.dx
	.type	__x86.get_pc_thunk.dx, @function
__x86.get_pc_thunk.dx:
.LFB27:
	.cfi_startproc
	movl	(%esp), %edx
	ret
	.cfi_endproc
.LFE27:
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
