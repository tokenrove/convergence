@ start -- GBA startup. (equivalent of crt0.o)
@ Convergence
@ Copyright Pureplay Games / 2002
@
@ $Id: start.s,v 1.3 2002/10/02 17:04:40 tek Exp $

	.section .text
	.arm
	.align

@ _start
@   Program entry point on boot.  Sets up stacks, et cetera.
@
	.global _start, boot_type, slave_idx
_start: bal 0f
	@ ROM header
	.fill 156,1,0		    @ XXX should be big N's logo
	.string "Convergence"	    @ title, must be 12 characters
	.byte 0,0,0,0
	.byte 0,0		    @ maker code?
	.byte 0x96,0,0,0,0,0,0,0,0,0
	.byte 0
	.byte 0xf0		    @ complement check
	.byte 0,0		    @ checksum
	.align
0:	bal 1f			    @ XXX for positioning

boot_type: .byte 0		    @ booted by rom by default
slave_idx: .byte 0		    @ master by default
	@ XXX should there be some extra stuff here for multiboot?
	.align


	@ Setup stacks.
.equ interrupt_sp, 0x3008000-0x60   @ 64 bytes for interrupt stack
.equ user_sp,      0x3008000-0x100

1:	mov r0, #0b10010	    @ IRQ mode
	msr cpsr, r0
	ldr sp, =interrupt_sp	    @ set the stack used during interrupts

	mov r0, #0b11111	    @ system mode
	msr cpsr, r0
	ldr sp, =user_sp	    @ set the stack used during user mode

	@ Copy in anything that needs to go in IWRAM immediately.
	ldr r0, =__iwram_code_start
	ldr r1, =__iwram_code_lma
	ldr r2, =__iwram_code_end
	sub r2, r2, r0
	bl dma_copy32

	@ Start the game.
	bl main
@ EOR _start

@ EOF start.s
