@ offset -- actor part offset calculators.
@ Convergence
@ Copyright Pureplay Games / 2002
@
@ $Id: offset.s,v 1.15 2002/11/14 19:41:22 tek Exp $

	.section .text
	.arm
	.align

	.include "actor.inc"


@ offset_stacked(actor)
@   Stacks parts on top of one-another.
@
	.global offset_stacked
offset_stacked:
	stmfd sp!, {r4-r6,lr}

	mov r4, #0
	mov r6, #0
	ldrb r1, [r0, #ACTRT_NPARTS]
	ldr r3, [r0, #ACTRT_PARTSPTR]
@   {
0:	ldrb r2, [r3]
	cmp r2, #0xff		    @ ignore the sprite if inactive.
	beq 1f

	strb r4, [r3, #3]	    @ offset Y
	stmfd sp!, {r0-r3}
	mov r0, r2
	bl sprite_getdimensions
	sub r4, r4, r1
	cmp r6, r0
	movgt r6, r0
	ldmfd sp!, {r0-r3}

1:	add r3, r3, #4
	subs r1, r1, #1
	bne 0b
@   }

	mov r3, #0		      @ \ wipes all four clip rectangle
	str r3, [r0, #ACTRT_CLIPXOFF] @ / variables
	mov r3, r6
	strb r3, [r0, #ACTRT_CLIPW]
	rsb r4, r4, #0
	mov r3, r4
	strb r3, [r0, #ACTRT_CLIPH]

	ldmfd sp!, {r4-r6,lr}
	bx lr
@ EOR offset_stacked


.equ CROW_ANM_STANDING, 0
.equ CROW_ANM_EATING, 1
.equ CROW_ANM_FLYING, 2

@ crow offsets -- actually deals with its animations. whatever.
@
@
	.global offset_crow
offset_crow:
	stmfd sp!, {r4-r7,lr}

	mov r6, #0
	mov r7, #0

	mov r4, r0

	@ Update animations
        ldr r5, [r4, #ACTRT_PARTSPTR]
        ldrb r3, [r5]
        cmp r3, #0xff               @ inactive
        beq 6f

	ldr r3, =actor_segs
	ldrb r1, [r4, #ACTRT_IDX]
	add r3, r3, r1, lsl #2
	ldrh r1, [r3, #ACTSEG_FLOOR]
	cmp r1, #0
	bne 2f

	@ Flying
1:	ldrb r0, [r5]
	mov r1, #CROW_ANM_FLYING
	bl sprite_setanim
	bal 6f

	@ Standing
2:	ldrb r0, [r5]
	mov r1, #CROW_ANM_STANDING
	bl sprite_setanim

6:
	mov r0, #0
	strb r0, [r4, #ACTRT_CLIPXOFF]
	mov r0, #2
	strb r0, [r4, #ACTRT_CLIPYOFF]
	mov r0, #16
	strb r0, [r4, #ACTRT_CLIPW]
	mov r0, #14
	strb r0, [r4, #ACTRT_CLIPH]

	ldmfd sp!, {r4-r7,pc}
@ EOR offset_crow

@ EOF offset.s
