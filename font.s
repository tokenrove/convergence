@ font -- quick render-to-vram font routines for debugging.
@ Convergence
@ Copyright Pureplay Games / 2002
@
@ $Id: font.s,v 1.4 2002/11/06 12:15:45 tek Exp $
@
@ NOTE:  This is primarily a hack for debugging.  It does not provide
@ advanced features, and isn't even very cooperative with other code on
@ this project.  If it is to be used for an extended period of time,
@ these things must be changed. (IE: registering its sprite and vram,
@ deciding whether we want to allow multipalette (256-color) writing for
@ shadows or not, allowing multiple font buffers to coexist, etc)
@
@ Nah, for shadows, just use a second copy of the sprite, with a black
@ palette.

	.section .ewram
	.align

@ pointer to font data
fontptr: .skip 4
@ pointer to our buffer in VRAM
vramptr: .skip 4

	.section .text
	.arm
	.align
	.include "gba.inc"

@ font_init(font)
@
	.global font_init
font_init:
	stmfd sp!, {r4-r6}

	ldr r1, =fontptr
	str r0, [r1]
	ldr r1, =vramptr
	mov r0, #vram_base
	add r0, r0, #0x10000
	add r0, r0, #0x7c00
	str r0, [r1]

	mov r0, #oam_base
	add r0, r0, #120*8
	mov r4, #0
	mov r5, #0x3e0

1:	mov r1, #140
	orr r1, r1, #0x4000
	strh r1, [r0], #2
	mov r1, r4
	orr r1, r1, #0x4000
	strh r1, [r0], #2
	mov r1, r5
	strh r1, [r0], #2
	mov r1, #0
	strh r1, [r0], #2
	add r4, r4, #32
	add r5, r5, #4
	cmp r5, #0x400
	blt 1b

	ldmfd sp!, {r4-r6}
	bx lr
@ EOR font_init


@ font_clear
@
	.global font_clear
font_clear:
	ldr r0, =vramptr
	ldr r0, [r0]
	mov r1, #0x400
	mov r2, #0
1:	str r2, [r0], #4
	subs r1, r1, #4
	bne 1b
	bx lr
@ EOR font_clear


@ font_paintstring(string,x,y)
@   Warning: x is intentionally twice what you expect.
@   Need to add subbyte deltas to support nice spacing etc
@
	.global font_paintstring
font_paintstring:
	stmfd sp!, {r4-r10,lr}

	ldr r3, =vramptr
	ldr r3, [r3]
	add r3, r3, r2, lsl #5	    @ buf is 64 4-bit pixels wide (2**5)
	add r3, r3, r1

	ldr r4, =fontptr
	ldr r4, [r4]

	@ for each character in the string (r0)
1:	ldrb r5, [r0], #1
	cmp r5, #0		    @ terminate on NUL
	beq 9f
	add r5, r5, #4		    @ offset to xlat table
	ldrb r5, [r4, r5]	    @ xlate
	@ XXX cheating!
	mov r5, r5, lsl #5	    @ oops... assumes 8*8 4-bpp font

	@ draw the character
	stmfd sp!, {r3,r4}
	add r4, r4, #256+4
	add r4, r4, r5
	mov r6, #8
2:	ldrh r5, [r4], #2
	strh r5, [r3]
	ldrh r5, [r4], #2
	strh r5, [r3,#2]
	add r3, r3, #4
	subs r6, r6, #1
	bne 2b
	ldmfd sp!, {r3,r4}
	add r3, r3, #32

	b 1b

	@ clean up and return
9:	ldmfd sp!, {r4-r10,lr}
	bx lr
@ EOR font_paintstring

@ EOF font.s
