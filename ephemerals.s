@ ephemerals -- transitory lightweight objects module.
@ Convergence
@ Copyright Pureplay Games / 2002
@
@ $Id: ephemerals.s,v 1.8 2002/11/21 14:48:20 tek Exp $

	.include "actor.inc"
	.include "sprite.inc"

	.section .ewram
	.align

@ Ephemeral run-time:
@ 0	word	Handler. (called once per frame)
@ 4	byte	Sprite handle.
@ 5	byte	Actor handle. (may be 0xff)
@ 6	hword	counter (temporary)
@ 8
.equ EPHEM_SIZE, 8

.equ MAXEPHEM, 64

ephem_buffer: .skip EPHEM_SIZE * MAXEPHEM
ephem_curp: .skip 1
.align

	.section .text
	.arm
	.align
	.include "gba.inc"

@ ephemeral_init
@
	.global ephemeral_init
ephemeral_init:
	ldr r0, =ephem_buffer
	mov r1, #MAXEPHEM
@ {
0:	mov r2, #0
	str r2, [r0], #4
	mov r2, #0xff
	str r2, [r0], #4
	subs r1, r1, #1
	bne 0b
@ }

	@ initialize blend registers
	@ XXX where should this go?
	ldr r0, =REG_BLDCNT
	mov r1, #0b01000000
	@mov r1, #0b01001111
	@orr r1, r1, #0b010000 << 8
	orr r1, r1, #0b001111 << 8
	strh r1, [r0]
	ldr r0, =REG_BLDALPHA
	mov r1, #9
	orr r1, r1, #12 << 8
	strh r1, [r0]

	ldr r0, =ephem_curp
	mov r2, #0
	strb r2, [r0]
	bx lr
@ EOR ephemeral_init


@ ephemeral_spawn(sprite, handler, actor, counter, palette [in r4])
@   Spawn a new ephemeral.  Replace (and remove) any old one if we've
@   filled up the buffer.  Sets the sprite's initial position to that of
@   the actor specified, if the actor reference isn't 0xff.
@
@   Returns the ephemeral's handle in r0.
@
	.global ephemeral_spawn
ephemeral_spawn:
	stmfd sp!, {r4-r6,lr}
	mov r6, r4
	ldr r5, =ephem_buffer
	ldr r4, =ephem_curp
	ldrb r4, [r4]
	add r5, r5, r4, lsl #3

	str r1, [r5], #4
	ldrb r1, [r5]
	cmp r1, #0xff
	beq 1f

	stmfd sp!, {r0-r3}
	mov r0, r1
	bl sprite_remove
	ldmfd sp!, {r0-r3}

1:	stmfd sp!, {r1-r3}
	mov r1, r6
	bl sprite_add
	ldmfd sp!, {r1-r3}
	strb r0, [r5], #1
	strb r2, [r5], #1
	strh r3, [r5], #2

	cmp r2, #0xff
	beq 1f

	ldr r3, =actor_rt
	add r3, r3, r2, lsl #5
	ldr r2, =sprite_rt
	add r2, r2, r0, lsl #4

	ldrh r0, [r3, #ACTRT_X]
	ldr r1, =camera_x
	ldrh r1, [r1]
	sub r0, r0, r1
	ldr r1, =camera_deltax
	ldrsb r1, [r1]
	sub r0, r0, r1
	strh r0, [r2, #SPRT_X]

	ldrh r0, [r3, #ACTRT_Y]
	ldr r1, =camera_y
	ldrh r1, [r1]
	sub r0, r0, r1
	ldr r1, =camera_deltay
	ldrsb r1, [r1]
	sub r0, r0, r1
	strb r0, [r2, #SPRT_Y]

1:	mov r0, r4

	ldr r5, =ephem_curp
	add r4, r4, #1
	cmp r4, #MAXEPHEM
	movge r4, #0
	strb r4, [r5]

	ldmfd sp!, {r4-r6,lr}
	bx lr
@ EOR ephemeral_spawn


@ ephemeral_disable(handle)
@   Kills the ephemeral specified by {handle}.  Be warned, this may not
@   be the same ephemeral that this handle referred to when it was
@   turned by ephemeral_spawn.
@
	.global ephemeral_disable
ephemeral_disable:
	stmfd sp!, {lr}
	ldr r1, =ephem_buffer
	add r1, r1, r0, lsl #3

	add r0, r0, #4
	ldrb r2, [r0]
	cmp r2, #0xff
	beq 1f

	stmfd sp!, {r0}
	mov r0, r2
	bl sprite_remove
	ldmfd sp!, {r0}

	mov r2, #0xff
	strb r2, [r0]

1:	ldmfd sp!, {lr}
	bx lr
@ EOR ephemeral_disable


@ ephemeral_update(void)
@   Update the live ephemerals.
@
	.global ephemeral_update
ephemeral_update:
	stmfd sp!, {r4,lr}
	ldr r0, =ephem_buffer
	mov r1, #MAXEPHEM
@ {
0:	ldrb r2, [r0, #4]
	cmp r2, #0xff
	beq 3f

	ldrh r3, [r0, #6]
	stmfd sp!, {r0-r3}
	ldr r4, [r0]
	cmp r4, #0
	beq 1f
	ldrb r1, [r0, #5]
	ldrh r3, [r0, #6]
	mov r0, r2
	mov r2, r3
	mov lr, pc
	mov pc, r4
1:	ldmfd sp!, {r0-r3}

	subs r3, r3, #1
	bne 2f

	stmfd sp!, {r0-r3}
	mov r0, r2
	bl sprite_remove
	ldmfd sp!, {r0-r3}
	mov r2, #0xff
	strb r2, [r0, #4]

2:	strh r3, [r0, #6]

3:	add r0, r0, #EPHEM_SIZE
	subs r1, r1, #1
	bne 0b
@ }
	ldmfd sp!, {r4,lr}
	bx lr
@ EOR ephemeral_update

@ EOF ephemerals.s
