@ gfx -- low-level graphics routines
@ Convergence
@ Copyright Pureplay Games / 2002
@
@ $Id: gfx.s,v 1.11 2002/11/17 13:45:35 tek Exp $

	.section .text
	.arm
	.align
	.include "gba.inc"

@ void gfx_set_mode_1(void)
@
	.global gfx_set_mode_1
gfx_set_mode_1:
	mov r0, #reg_base
	mov r1, #0x41
	orr r1, r1, #0x1700
	strh r1, [r0]

	mov r0, #palram_base
	mov r1, #0x200
	mov r2, #0
0:	strh r2, [r0], #2
	subs r1, r1, #1
	bne 0b

	bx lr
@ EOR gfx_set_mode_1


@ void gfx_set_mode_4(void)
@
	.global gfx_set_mode_4
gfx_set_mode_4:
	mov r0, #reg_base
	mov r1, #0x44
	orr r1, r1, #0x0400
	strh r1, [r0]

	mov r0, #palram_base
	mov r1, #0x200
	mov r2, #0
0:	strh r2, [r0], #2
	subs r1, r1, #1
	bne 0b

	bx lr
@ EOR gfx_set_mode_4


@ void gfx_set_mode(int mode)
@
	.global gfx_set_mode
gfx_set_mode:
	mov r1, r0
	mov r0, #reg_base
	orr r1, r1, #0x40
	orr r1, r1, #0x1000
	strh r1, [r0]		    @ REG_DISPCNT

	bx lr
@ EOR gfx_set_mode


@ gfx_enable_bg(bgidx)
	.global gfx_enable_bg
gfx_enable_bg:
	ldr r1, =REG_DISPCNT
	ldrh r2, [r1]
	orr r2, r2, r0, lsl #8
	strh r2, [r1]
	bx lr
@ EOR gfx_enable_bg

@ void gfx_wait_vblank(void)
@
	.global gfx_wait_vblank
gfx_wait_vblank:
	mov r0, #reg_base
0:	ldrh r1, [r0, #6]
	cmp r1, #160
	bne 0b
	bx lr
@ EOR gfx_wait_vblank


@ gfx_set_bg_palette(word)
@
	.global gfx_set_bg_palette
gfx_set_bg_palette:
	mov r1, #palram_base
	mov r2, #0x200
0:	ldr r3, [r0], #4
	str r3, [r1], #4
	subs r2, r2, #4
	bne 0b
	bx lr
@ EOR gfx_set_bg_palette


@ gfx_set_spr_palette(word)
@
	.global gfx_set_spr_palette
gfx_set_spr_palette:
	mov r1, #palram_base
	add r1, r1, #0x200
	mov r2, #0x200
0:	ldr r3, [r0], #4
	str r3, [r1], #4
	subs r2, r2, #4
	bne 0b
	bx lr
@ EOR gfx_set_spr_palette


@ EOF gfx.s
