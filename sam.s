@ sam -- Sam's handlers
@ Convergence
@ Copyright Pureplay Games / 2002
@
@ $Id: sam.s,v 1.50 2002/12/12 19:38:21 tek Exp $

	.include "actor.inc"
	.include "sprite.inc"
	.include "game.inc"
	.include "physics.inc"
	.include "gba.inc"
        .include "offset.inc"

@ Sam's state values.
@   0	byte	invulnerability counter
.equ SAMST_INVULNCTR, 0
@   1	byte	jump counter
.equ SAMST_JUMPCTR, 1
@   2	byte	walljump counter
.equ SAMST_WALLCTR, 2
@   3	byte	xxxx xhad
@		    x = unused
@		    h = hit direction (0 fore, 1 back)
.equ SAM_FLAG_HITDIRECTION, 4
@		    a = attack left (0) / right (1)
.equ SAM_FLAG_ATTACKFIST, 2
@		    d = ducking
.equ SAM_FLAG_DUCK, 1
.equ SAMST_FLAGS, 3
@   4	byte	attack counter
.equ SAMST_ATTACKCTR, 4

@ Sam's constants.
.equ SAM_WALKACCEL,     32
.equ SAM_MAX_ACCELX,    128
@.equ SAM_JUMPCTR_INIT,  18
.equ SAM_JUMPCTR_INIT,  1
.equ SAM_JUMPCTR_SHIFT, 7
.equ SAM_JUMP_POWER,    0x800
.equ SAM_JUMP_IMPULSE,	0x200
.equ SAM_WALLCTR_INIT,  40
.equ SAM_WALLCTR_SHIFT, 3
.equ SAM_WALL_POWER,    0x300
.equ SAM_WALL_VPOWER,   0x300
@ NOTE: be careful when changing Sam's max ladder velocity, as a poor
@ choice will produce a very ugly beat frequency between the scrolling
@ and the rate of LCD refresh.
.equ SAM_MAX_LADDER_VELOCITY, 0x100

.equ SAM_ATTACK_INIT, 17
.equ SAM_ATTACK_BEGIN_LIMIT, SAM_ATTACK_INIT-16
.equ SAM_WAVE_LENGTH, 14
.equ SAM_WAVE_DAMAGE, 12
.equ SAM_FIST_DAMAGE, 5
.equ SAM_INVULN_PERIOD, 20
.equ SAM_PHASE_COLLISION_DAMAGE, 14

.equ PARANOIA_TIME, 120
.equ LOOK_TRIGGER, 2
.equ LOOK_FINISHED, 1

.equ SAM_BELMONT_VY, 0x200
.equ SAM_BELMONT_VX, 0x100

.equ SAM_HIT_SFX, 0x548
.equ SAM_ATTACK_SFX, 0x510

@ Constants for Sam's animations
.equ SAM_TOPANM_STAND, 0
.equ SAM_TOPANM_WALK, 1
.equ SAM_TOPANM_CLIMB, 2
.equ SAM_TOPANM_JUMP, 3
.equ SAM_TOPANM_HITFRONT, 4
.equ SAM_TOPANM_HITBACK, 5
.equ SAM_TOPANM_LOOK, 6
.equ SAM_TOPANM_BOUNCE, 7
.equ SAM_TOPANM_SKID, 8
.equ SAM_TOPANM_DUCK, 9
.equ SAM_TOPANM_CLIMBSTOPPED, 10
.equ SAM_TOPANM_STRIKERIGHT, 11
.equ SAM_TOPANM_STRIKELEFT, 12
.equ SAM_BOTANM_STAND, 0
.equ SAM_BOTANM_WALK, 1
.equ SAM_BOTANM_CLIMB, 2
.equ SAM_BOTANM_JUMP, 3
.equ SAM_BOTANM_BOUNCE, 4
.equ SAM_BOTANM_SKID, 5
.equ SAM_BOTANM_DUCK, 6
.equ SAM_BOTANM_CLIMBSTOPPED, 7

	.section .ewram
	.align

debounce: .skip 2
@ Justification for making this static: A) it's only cosmetic, and B)
@ chance of there being two Sams on screen at a time is too slim for it
@ to matter.
look_counter: .skip 1
.align

	.section .text
	.arm
	.align



@ damage_sam(cause id, type, us, magnitude)
@
	.global damage_sam
damage_sam:
	stmfd sp!, {r4-r5,lr}
	mov r5, r3

	cmp r0, #0xff
	moveq r4, #0
	ldrne r4, =actor_rt
	addne r4, r4, r0, lsl #5

	@ invulnerability counter
	ldr r3, [r2, #ACTRT_STATE]
	ldrb r0, [r3, #SAMST_INVULNCTR]
	cmp r0, #0
	bne 1f
	mov r0, #SAM_INVULN_PERIOD
	strb r0, [r3, #SAMST_INVULNCTR]

	stmfd sp!, {r0-r3}
	@ phasic damage does 20% more damage
	cmp r1, #DAMAGE_PHASIC
	bne 2f

	ldr r1, =recip_table
	ldrh r1, [r1, #6]	    @ 2 * (5 - 2)
	mul r0, r1, r5
	add r5, r5, r0, asr #16

2:	ldrsb r0, [r2, #ACTRT_HEALTH]
	cmp r0, #0
	addge r0, r0, r5
	sublt r0, r0, r5
	strb r0, [r2, #ACTRT_HEALTH]

	mov r0, #0
	strb r0, [r3, #SAMST_ATTACKCTR]
	strb r0, [r3, #SAMST_JUMPCTR]
	strb r0, [r3, #SAMST_WALLCTR]
        @ Can't hold on to a wall while getting hit
        ldr r0, =actor_segs
        ldrh r1, [r2, #ACTRT_IDX]
        add r0, r0, r1, lsl #2
        mov r1, #0
        strh r1, [r0, #ACTSEG_WALL]

	@ Belmont hit
	ldrsh r0, [r2, #ACTRT_VY]
	cmp r0, #0
	subge r0, r0, #SAM_BELMONT_VY
	strgeh r0, [r2, #ACTRT_VY]

	ldrh r0, [r2, #ACTRT_X]
	cmp r4, #0
	beq 2f
	ldrh r1, [r4, #ACTRT_X]
	cmp r0, r1
	bgt 4f
	blt 5f

2:	ldrb r1, [r2, #ACTRT_FLAGS]
	tst r1, #ACTRT_FLAG_FACING
	ldrsh r0, [r2, #ACTRT_VX]
	subeq r0, r0, #SAM_BELMONT_VX
	addne r0, r0, #SAM_BELMONT_VX
	strh r0, [r2, #ACTRT_VX]

	ldrb r0, [r3, #SAMST_FLAGS]
	biceq r0, r0, #SAM_FLAG_HITDIRECTION
	orrne r0, r0, #SAM_FLAG_HITDIRECTION
	strb r0, [r3, #SAMST_FLAGS]
	bal 3f

4:	ldrsh r0, [r2, #ACTRT_VX]
	add r0, r0, #SAM_BELMONT_VX
	strh r0, [r2, #ACTRT_VX]

	ldrb r1, [r2, #ACTRT_FLAGS]
	ldrb r0, [r3, #SAMST_FLAGS]
	tst r1, #ACTRT_FLAG_FACING
	orreq r0, r0, #SAM_FLAG_HITDIRECTION
	bicne r0, r0, #SAM_FLAG_HITDIRECTION
	strb r0, [r3, #SAMST_FLAGS]
	bal 3f

5:	ldrsh r0, [r2, #ACTRT_VX]
	sub r0, r0, #SAM_BELMONT_VX
	strh r0, [r2, #ACTRT_VX]

	ldrb r1, [r2, #ACTRT_FLAGS]
	ldrb r0, [r3, #SAMST_FLAGS]
	tst r1, #ACTRT_FLAG_FACING
	biceq r0, r0, #SAM_FLAG_HITDIRECTION
	orrne r0, r0, #SAM_FLAG_HITDIRECTION
	strb r0, [r3, #SAMST_FLAGS]

3:	@ldr r0, =sam_spr
	@ldr r1, =ephem_samhit
	@mov r3, #SAM_INVULN_PERIOD
	@ldrb r4, [r2, #ACTRT_FLAGS]
	@tst r4, #ACTRT_FLAG_WORLD_ALPHA
	@movne r4, #PAL_BETA
	@moveq r4, #PAL_ALPHA
	@ldrb r2, [r2, #ACTRT_IDX]
	@bl ephemeral_spawn

        @ make noise
        mov r0, #3
        mov r1, #0
        ldr r2, =SAM_HIT_SFX
        bl music_play_sfx

	ldmfd sp!, {r0-r3}
1:

	ldmfd sp!, {r4-r5,lr}
	bx lr
@ EOR damage_sam 


@ ephem_samhit(sprite,actor,counter)
@ XXX track current actor animation and offsets
@ XXX add sam's torso, use his offset function to setup the proper
@     look
@
ephem_samhit:
	stmfd sp!, {r4-r6,lr}

	ldr r4, =sprite_rt
	add r4, r4, r0, lsl #4
	ldr r5, =sine_lut

	ldr r6, =actor_rt
	add r1, r6, r1, lsl #5
	mov r3, #SAM_TOPANM_HITFRONT
	orr r3, r3, #0x80
	orr r3, r3, #0b1000000
	strb r3, [r4, #SPRT_ANIMIDX]
	mov r3, #0
	strb r3, [r4, #SPRT_FRAMEIDX]
	mov r3, #1
	strb r3, [r4, #SPRT_COUNTER]

	stmfd sp!, {r0-r3}
	mov r1, #PAL_BETA
	bl sprite_setpalette
	ldmfd sp!, {r0-r3}

	tst r2, #0x7
	bne 1f

	stmfd sp!, {r0-r3}
	mov r3, r2		    @ counter = theta/2
	mov r3, r3, lsl #2
	mov r6, r3, asr #3
	rsbs r6, r6, #0xff	    @ radius
	rsblt r6, r6, #0

	and r3, r3, #0xff
	mov r3, r3, lsl #1

	ldrh r0, [r1, #ACTRT_Y]
	ldr r2, =camera_y
	ldrh r2, [r2]
	sub r0, r0, r2
	ldr r2, [r1, #ACTRT_PARTSPTR]
	add r2, r2, #4
	ldrsb r2, [r2, #3]
	add r0, r0, r2
	ldrsh r2, [r5, r3]
	mov r2, r2, asr #10
	mul r2, r6, r2
	add r2, r0, r2, asr #8
	strb r2, [r4, #SPRT_Y]

	eor r3, r3, #0x80
	ldrh r0, [r1, #ACTRT_X]
	ldr r2, =camera_x
	ldrh r2, [r2]
	sub r0, r0, r2
	ldr r2, [r1, #ACTRT_PARTSPTR]
	add r2, r2, #4
	ldrsb r2, [r2, #2]
	add r0, r0, r2
	ldrsh r3, [r5, r3]
	mov r3, r3, asr #10
	mul r3, r6, r3
	add r3, r0, r3, asr #8
	strh r3, [r4, #SPRT_X]
	ldmfd sp!, {r0-r3}

1:	ldmfd sp!, {r4-r6,lr}
	bx lr
@ EOR ephem_samhit


@ samstrike_handler(sprite, actor, counter)
@ Update Sam's strike.
@   XXX this should remove itself if it finds Sam in a non-attack
@   position. (ie walljumping)
@
samstrike_handler:
	stmfd sp!, {r4,lr}

	ldr r3, =actor_rt
	add r1, r3, r1, lsl #5

	ldrb r3, [r1, #ACTRT_FLAGS]
	tst r3, #ACTRT_FLAG_WORLD_ALPHA
	moveq r3, #PAL_ALPHA
	movne r3, #PAL_BETA

	stmfd sp!, {r0-r2}
	mov r1, r3
	bl sprite_setpalette
	ldmfd sp!, {r0-r2}

	ldr r3, [r1, #ACTRT_STATE]
	ldrb r4, [r3, #SAMST_ATTACKCTR]
	@ If the counter isn't equal to our attack counter,
	@ kill this ephemeral (the counter's been reset).
	cmp r4, r2
	bne 1f

	bl sprite_remove
	bx lr

1:	ldrb r3, [r3, #SAMST_FLAGS]
	tst r3, #SAM_FLAG_ATTACKFIST
	moveq r3, #0
	movne r3, #1
	orreq r3, r3, #0x20	    @ priority 1
	orrne r3, r3, #0x60	    @ priority 2

	ldr r4, =sprite_rt
	add r4, r4, r0, lsl #4

	strb r3, [r4, #SPRT_ANIMIDX]

	ldrh r0, [r1, #ACTRT_Y]
	ldr r2, =camera_y
	ldrh r2, [r2]
	sub r0, r0, r2
	ldr r2, =camera_deltay
	ldrsb r2, [r2]
	sub r0, r0, r2
	ldr r2, [r1, #ACTRT_PARTSPTR]
	add r2, r2, #4
	ldrsb r2, [r2, #3]
	add r0, r0, r2
	strb r0, [r4, #SPRT_Y]

	ldrh r0, [r1, #ACTRT_X]
	ldr r2, =camera_x
	ldrh r2, [r2]
	sub r0, r0, r2
	ldr r2, =camera_deltax
	ldrsb r2, [r2]
	sub r0, r0, r2
	ldr r2, [r1, #ACTRT_PARTSPTR]
	add r2, r2, #4
	ldrsb r2, [r2, #2]
	add r0, r0, r2
	strh r0, [r4, #SPRT_X]

	ldrb r2, [r1, #ACTRT_FLAGS]
	tst r2, #ACTRT_FLAG_FACING
	ldrb r0, [r4, #SPRT_XFLAGS]
	orrne r0, r0, #0b1000
	biceq r0, r0, #0b1000
	strb r0, [r4, #SPRT_XFLAGS]

	ldmfd sp!, {r4,lr}
	bx lr
@ EOR samstrike_handler


@ wave_handler(sprite, actor, counter)
@ Update Sam's wave.
@
wave_handler:
	stmfd sp!, {r4,lr}

	ldr r3, =actor_rt
	add r1, r3, r1, lsl #5

	ldrb r3, [r1, #ACTRT_FLAGS]
	tst r3, #ACTRT_FLAG_WORLD_ALPHA
	moveq r3, #PAL_ALPHA
	movne r3, #PAL_BETA

	stmfd sp!, {r0-r2}
	mov r1, r3
	bl sprite_setpalette
	ldmfd sp!, {r0-r2}

	ldr r4, =sprite_rt
	add r4, r4, r0, lsl #4

	@ If the counter isn't equal to the wave length,
	@ skip the initialization parts below and just float.
	cmp r2, #SAM_WAVE_LENGTH
	bne 1f

	mov r3, #0x20		    @ priority 1
	strb r3, [r4, #SPRT_ANIMIDX]

	@ register us as deadly
	stmfd sp!, {r0-r2}
	ldr r1, =wave_collider
	bl collision_add
	ldmfd sp!, {r0-r2}

	ldrh r0, [r1, #ACTRT_Y]
	ldr r2, =camera_y
	ldrh r2, [r2]
	sub r0, r0, r2
	ldr r2, =camera_deltay
	ldrsb r2, [r2]
	sub r0, r0, r2
	ldr r2, [r1, #ACTRT_PARTSPTR]
	add r2, r2, #4
	ldrsb r2, [r2, #3]
	add r0, r0, r2
	strb r0, [r4, #SPRT_Y]

	ldrh r0, [r1, #ACTRT_X]
	ldr r2, =camera_x
	ldrh r2, [r2]
	sub r0, r0, r2
	ldr r2, =camera_deltax
	ldrsb r2, [r2]
	sub r0, r0, r2
	ldr r2, [r1, #ACTRT_PARTSPTR]
	add r2, r2, #4
	ldrsb r2, [r2, #2]
	add r0, r0, r2
	strh r0, [r4, #SPRT_X]

	ldrb r0, [r4, #SPRT_XFLAGS]
	ldrb r2, [r1, #ACTRT_FLAGS]
	tst r2, #ACTRT_FLAG_FACING
	orrne r0, r0, #0b1000
	biceq r0, r0, #0b1000
	strb r0, [r4, #SPRT_XFLAGS]
	bal 9f

	@ float "peacefully".
1:	ldrh r0, [r4, #SPRT_X]
	@ check direction
	ldrb r2, [r4, #SPRT_XFLAGS]
	tst r2, #0b1000
	addeq r0, r0, #2
	subne r0, r0, #2
	strh r0, [r4, #SPRT_X]

9:	ldmfd sp!, {r4,lr}
	bx lr
@ EOR wave_handler 


@ wave_collider(this sprite, the other sprite)
@ Wave collision handler.
@
wave_collider:
	stmfd sp!, {r4,r5,lr}

	@ look up our sprite in the ephemerals lut and check our
	@ alliegences (which actor spawned us)

	mov r5, r0

	@ XXX lazy hack!  should find who spawned us (so we don't hit 'em)
	ldr r0, =hero_handle
	ldrb r0, [r0]

	@ if the other sprite is worthy of damage, call their damage
	@ handler.
	ldr r2, =actor_sprite_lut
	ldrb r3, [r2, r1]
	cmp r3, #0xff
	beq 9f
	cmp r3, r0
	beq 9f

	ldr r2, =actor_rt
	add r2, r2, r3, lsl #5
	ldrh r1, [r2, #ACTRT_TYPE]
	ldr r3, =archetype_table
	mov r1, r1, lsl #1
	ldrh r1, [r3, r1]
	add r3, r3, r1, lsl #2
	add r3, r3, #7
	ldrb r1, [r3], #1
	add r3, r3, r1, lsl #3
	ldr r4, [r3, #16]
	cmp r4, #0
	beq 9f

	@ r0 is our master's actor id,
	@ r2 is the actor _rt_ of the damned
	mov r1, #DAMAGE_PHASIC
	mov r3, #SAM_WAVE_DAMAGE
	mov lr, pc
	mov pc, r4

	@ now commit suicide
	mov r0, r5
	bl collision_remove
	mov r0, r5
	bl sprite_remove

9:	ldmfd sp!, {r4,r5,lr}
	bx lr
@ EOR wave_collider


@ human_sam(actor)
@
	.global human_sam
human_sam:
	stmfd sp!, {r4-r8,lr}

	ldr r4, [r0, #ACTRT_STATE]

	ldr r1, =actor_segs
	ldrb r3, [r0, #ACTRT_IDX]
	add r1, r1, r3, lsl #2
	ldrh r7, [r1, #ACTSEG_FLOOR]
	ldrh r8, [r1, #ACTSEG_WALL]
 
        @ Danger!  This currently means you can't down+jump down onto
        @ another passable segment!
        ldrb r3, [r0, #ACTRT_FLAGS]
        tst r3, #ACTRT_FLAG_SLOPEIGNORE
        beq 1f
        cmp r7, #0
        beq 1f

        ldr r2, =linebank
        ldr r2, [r2]
        add r3, r7, r7, lsl #1
        add r2, r2, r3, lsl #2
        ldrb r2, [r2, #SEGRT_TYPE]
        tst r2, #SEGTYPE_FLAG_PASS
        ldreqb r3, [r0, #ACTRT_FLAGS]
        biceq r3, r3, #ACTRT_FLAG_SLOPEIGNORE
        streqb r3, [r0, #ACTRT_FLAGS]

1:      mov r2, #0
        strh r2, [r0, #ACTRT_AY]

	@ If we're in a position to wall-jump, force facing to
	@ the opposite of the wall.
	cmp r8, #0
	beq 8f

	ldr r3, =linebank
	ldr r3, [r3]
	add r1, r8, r8, lsl #1
	add r3, r3, r1, lsl #2
	ldrb r1, [r3, #SEGRT_TYPE]
	ldrb r2, [r0, #ACTRT_FLAGS]
	tst r1, #SEGTYPE_FLAG_X
	bicne r2, r2, #1
	orreq r2, r2, #1
	tst r1, #SEGTYPE_FLAG_LADDER
	eorne r2, r2, #1
	strb r2, [r0, #ACTRT_FLAGS]

	@ if we're on a ladder, deal with controls differently.
	tst r1, #SEGTYPE_FLAG_LADDER
	beq 8f

	ldr r1, =REG_KEY
	ldrh r1, [r1]

	tst r1, #KEY_UP
	bne 1f

	@ldrh r2, [r0, #ACTRT_AY]
	mov r2, #0
	sub r2, r2, #SAM_WALKACCEL>>1
	sub r2, r2, #GRAVITY
	strh r2, [r0, #ACTRT_AY]
	bal 2f

1:	tst r1, #KEY_DOWN
	bne 1f

	@ldrh r2, [r0, #ACTRT_AY]
	mov r2, #0
	add r2, r2, #SAM_WALKACCEL>>1
	strh r2, [r0, #ACTRT_AY]
	bal 2f

1:	mov r2, #0
	strh r2, [r0, #ACTRT_AY]
	mov r2, #0
	strh r2, [r0, #ACTRT_VY]

2:	tst r1, #KEY_A
	bne 1f

	ldrb r3, [r4, #SAMST_WALLCTR]
	cmp r3, #0

	ldr r2, =debounce
	ldrh r2, [r2]
	tst r2, #KEY_A		    @ debounce
	bne 4f

	ldrb r3, [r4, #SAMST_WALLCTR]
	cmp r3, #0
	moveq r3, #SAM_WALLCTR_INIT
	streqb r3, [r4, #SAMST_WALLCTR]
	bal 4f

1:	ldrb r3, [r4, #SAMST_WALLCTR]
	cmp r3, #0
	beq 4f

	bl sam_walljump
	mov r3, #0
	strb r3, [r4, #SAMST_WALLCTR]

4:	tst r1, #KEY_B
	ldreq r2, =debounce
	ldreqh r2, [r2]
	tsteq r2, #KEY_B
	bne 1f

	@ attack?

1:	ldrsh r2, [r0, #ACTRT_VY]
	mov r3, #SAM_MAX_LADDER_VELOCITY
	cmp r2, r3
	rsblt r3, r3, #0
	cmplt r3, r2
	movgt r2, r3
	strh r2, [r0, #ACTRT_VY]

	bal 9f

	@ Not on a ladder.
8:	ldr r1, =REG_KEY
	ldrh r1, [r1]

	ldrb r2, [r4, #SAMST_FLAGS]
	tst r2, #SAM_FLAG_DUCK
	bne 3f

	tst r1, #KEY_RIGHT
	bne 1f

	ldr r3, =look_counter
	mov r2, #0
	strb r2, [r3]

	@ if the wall is set but the floor is not
	cmp r8, #0
	bne 4f

	ldrb r2, [r0, #ACTRT_FLAGS]
	bic r2, r2, #1		    @ face right
	strb r2, [r0, #ACTRT_FLAGS]

4:	cmp r7, #0
	beq 4f

	ldrb r2, [r0, #ACTRT_FLAGS]
	bic r2, r2, #1		    @ face right
	strb r2, [r0, #ACTRT_FLAGS]

4:	@ if we have something to push against...
	cmp r7, #0
	beq 1f
	ldrsh r2, [r0, #ACTRT_AX]
	add r2, r2, #SAM_WALKACCEL
	strh r2, [r0, #ACTRT_AX]
	bal 2f

1:	tst r1, #KEY_LEFT
	bne 1f

	ldr r3, =look_counter
	mov r2, #0
	strb r2, [r3]

	cmp r8, #0
	bne 4f

	ldrb r2, [r0, #ACTRT_FLAGS]
	orr r2, r2, #1		    @ face left
	strb r2, [r0, #ACTRT_FLAGS]

4:	cmp r7, #0
	beq 4f

	ldrb r2, [r0, #ACTRT_FLAGS]
	orr r2, r2, #1		    @ face left
	strb r2, [r0, #ACTRT_FLAGS]

4:	@ If we have something to push against...
	cmp r7, #0
	beq 1f
	ldrsh r2, [r0, #ACTRT_AX]
	sub r2, r2, #SAM_WALKACCEL
	strh r2, [r0, #ACTRT_AX]
	bal 2f

1:	mov r2, #0
	strh r2, [r0, #ACTRT_AX]
	ldr r3, =look_counter
	ldrb r2, [r3]
	cmp r2, #0
	moveq r2, #PARANOIA_TIME
	streqb r2, [r3]

        @ slope selection
2:	tst r1, #KEY_UP
	bne 3f

	ldrb r2, [r0, #ACTRT_FLAGS]
        orr r2, r2, #ACTRT_FLAG_SLOPESELECTION
        strb r2, [r0, #ACTRT_FLAGS]
        bal 1f

3:	ldrb r2, [r0, #ACTRT_FLAGS]
        bic r2, r2, #ACTRT_FLAG_SLOPESELECTION
        strb r2, [r0, #ACTRT_FLAGS]
        @ duck
1:	tst r1, #KEY_DOWN
	bne 2f

	ldr r3, =look_counter
	mov r2, #0
	strb r2, [r3]

	ldrb r2, [r4, #SAMST_FLAGS]
	orr r2, r2, #SAM_FLAG_DUCK
	strb r2, [r4, #SAMST_FLAGS]
	mov r2, #0
	strh r2, [r0, #ACTRT_AX]

        @ down+jump
        tst r1, #KEY_A
        bne 1f
        @ check that we are on a passable segment here
        ldr r2, =linebank
        ldr r2, [r2]
        add r3, r7, r7, lsl #1
        add r2, r2, r3, lsl #2
        ldrb r3, [r2, #SEGRT_TYPE]
        tst r3, #SEGTYPE_FLAG_PASS
        beq 4f
        ldrb r3, [r0, #ACTRT_FLAGS]
        orr r3, r3, #ACTRT_FLAG_SLOPEIGNORE
        strb r3, [r0, #ACTRT_FLAGS]
	ldr r5, =actor_segs
	ldrb r3, [r0, #ACTRT_IDX]
	add r5, r5, r3, lsl #2
	mov r7, #0
	strh r7, [r5, #ACTSEG_FLOOR]
        bal 4f

2:	ldrb r2, [r4, #SAMST_FLAGS]
	bic r2, r2, #SAM_FLAG_DUCK
	strb r2, [r4, #SAMST_FLAGS]
	@ XXX check for obstructions when standing up, here.

1:	tst r1, #KEY_A
	bne 1f

	ldr r3, =look_counter
	mov r2, #0
	strb r2, [r3]

	ldrb r3, [r4, #SAMST_WALLCTR]
	cmp r3, #0
	movne r3, #GRAVITY
	rsbne r3, r3, #0
	strneh r3, [r0, #ACTRT_AY]  @ don't slide down the wall
	movne r3, #0
	strneh r3, [r0, #ACTRT_VY]

	ldr r2, =debounce
	ldrh r2, [r2]
	tst r2, #KEY_A
	bne 4f

	@ Jump, if we're not already in the air.
	cmp r7, #0
	beq 2f
	ldrb r3, [r4, #SAMST_JUMPCTR]
	cmp r3, #0
	moveq r3, #SAM_JUMPCTR_INIT
	streqb r3, [r4, #SAMST_JUMPCTR]
	bal 4f

2:	mov r3, #0
	strb r3, [r4, #SAMST_JUMPCTR]

	@ Check for wall-jump.
	cmp r8, #0
	beq 3f

	ldrb r3, [r4, #SAMST_WALLCTR]
	cmp r3, #0
	moveq r3, #SAM_WALLCTR_INIT
	streqb r3, [r4, #SAMST_WALLCTR]
	bal 4f

	@ no A button
1:	ldrb r3, [r4, #SAMST_JUMPCTR]
	cmp r3, #0
	beq 2f

	bl sam_jump
	mov r3, #0
	strb r3, [r4, #SAMST_JUMPCTR]
	bal 4f

2:	ldrb r3, [r4, #SAMST_WALLCTR]
	cmp r3, #0
	beq 4f

	bl sam_walljump
3:	mov r3, #0
	strb r3, [r4, #SAMST_WALLCTR]

4:      ldr r2, =debounce
	ldrh r2, [r2]
	tst r1, #KEY_B
	tsteq r2, #KEY_B
	bne 9f

	@ Attack...
	@ check our attack counter...  if we are already attacking, and
	@ the beginning time limit has passed, alternate the type of
	@ attack and spawn a new wave ephemeral.
	ldrb r2, [r4, #SAMST_ATTACKCTR]
	cmp r2, #SAM_ATTACK_BEGIN_LIMIT
	bgt 9f
	@ no attack while wall-jumping
	cmp r8, #0
	bne 9f

	@ if we aren't already attacking, we always use the left fist
	ldrb r3, [r4, #SAMST_FLAGS]
	cmp r2, #0
	biceq r3, r3, #SAM_FLAG_ATTACKFIST
	eorne r3, r3, #SAM_FLAG_ATTACKFIST
	strb r3, [r4, #SAMST_FLAGS]

4:	mov r2, #SAM_ATTACK_INIT
	strb r2, [r4, #SAMST_ATTACKCTR]

	@ spawn glowing fist ephemeral
	stmfd sp!, {r0,r1,r4}
	ldrb r2, [r0, #ACTRT_IDX]
	ldrb r4, [r0, #ACTRT_FLAGS]
	tst r4, #ACTRT_FLAG_WORLD_ALPHA
	moveq r4, #PAL_ALPHA
	movne r4, #PAL_BETA
	ldr r0, =samstrike_spr
	ldr r1, =samstrike_handler
	mov r3, #SAM_ATTACK_INIT
	bl ephemeral_spawn
	ldmfd sp!, {r0,r1,r4}

	@ spawn wave ephemeral
	stmfd sp!, {r0,r1,r4}
	ldrb r2, [r0, #ACTRT_IDX]
	ldrb r4, [r0, #ACTRT_FLAGS]
	tst r4, #ACTRT_FLAG_WORLD_ALPHA
	moveq r4, #PAL_ALPHA
	movne r4, #PAL_BETA
	ldr r0, =wave_spr
	ldr r1, =wave_handler
	mov r3, #SAM_WAVE_LENGTH
	bl ephemeral_spawn

        @ make noise
        mov r0, #3
        mov r1, #0
        ldr r2, =SAM_ATTACK_SFX
        bl music_play_sfx
	ldmfd sp!, {r0,r1,r4}

9:      ldr r2, =debounce
	ldrh r2, [r2]
	tst r1, #KEY_TRIGGER_L
        tsteq r2, #KEY_TRIGGER_L
	bne 1f

	ldr r2, =desired_world
	ldrb r3, [r2]
        cmp r3, #0
        beq 2f
        stmfd sp!, {r0,r1}
        ldr r1, =alpha_segtree
        ldr r1, [r1]
        ldr r2, =safety_scan
        mov lr, pc
        mov pc, r2
        mov r2, r0
        ldmfd sp!, {r0,r1}

        cmp r2, #0
        bne 3f

	ldrb r2, [r0, #ACTRT_FLAGS]
	orr r2, r2, #ACTRT_FLAG_WORLD_ALPHA
	bic r2, r2, #ACTRT_FLAG_WORLD_BETA
	strb r2, [r0, #ACTRT_FLAGS]

	ldr r2, =desired_world
	mov r3, #0
	strb r3, [r2]
        bal 2f

3:      stmfd sp!, {r0,r1,r4}
        ldrh r2, [r0, #ACTRT_TYPE]
        mov r2, r2, lsl #1
        ldr r3, =archetype_table
        ldrh r2, [r3, r2]
        add r3, r3, r2, lsl #2
        add r3, r3, #7
        ldrb r2, [r3], #1
        add r3, r3, r2, lsl #3
        ldr r4, [r3, #16]
        mov r2, r0
        mov r0, #0xff
        mov r1, #DAMAGE_PHASIC
        mov r3, #SAM_PHASE_COLLISION_DAMAGE
        cmp r4, #0
        movne lr, pc
        movne pc, r4
        ldmfd sp!, {r0,r1,r4}

1:	tst r1, #KEY_TRIGGER_R
        tsteq r2, #KEY_TRIGGER_R
	bne 2f

	ldr r2, =desired_world
	ldrb r3, [r2]
        cmp r3, #1
        beq 2f
        stmfd sp!, {r0,r1}
        ldr r1, =beta_segtree
        ldr r1, [r1]
        ldr r2, =safety_scan
        mov lr, pc
        mov pc, r2
        mov r2, r0
        ldmfd sp!, {r0,r1}

        cmp r2, #0
        bne 3f

	ldrb r2, [r0, #ACTRT_FLAGS]
	bic r2, r2, #ACTRT_FLAG_WORLD_ALPHA
	orr r2, r2, #ACTRT_FLAG_WORLD_BETA
	strb r2, [r0, #ACTRT_FLAGS]

        ldr r2, =desired_world
	mov r3, #1
	strb r3, [r2]
        bal 2f

3:      stmfd sp!, {r0,r1,r4}
        ldrh r2, [r0, #ACTRT_TYPE]
        mov r2, r2, lsl #1
        ldr r3, =archetype_table
        ldrh r2, [r3, r2]
        add r3, r3, r2, lsl #2
        add r3, r3, #7
        ldrb r2, [r3], #1
        add r3, r3, r2, lsl #3
        ldr r4, [r3, #16]
        mov r2, r0
        mov r0, #0xff
        mov r1, #DAMAGE_PHASIC
        mov r3, #SAM_PHASE_COLLISION_DAMAGE
        cmp r4, #0
        movne lr, pc
        movne pc, r4
        ldmfd sp!, {r0,r1,r4}

2:	@ Save debounce
	mvn r1, r1
	ldr r2, =debounce
	strh r1, [r2]

	@ Limit acceleration.
6:	ldrsh r2, [r0, #ACTRT_AX]
	mov r3, #SAM_MAX_ACCELX	    @ XXX base on speed?
	cmp r2, r3
	movgt r2, r3
	rsb r3, r3, #0
	cmp r2, r3
	movlt r2, r3
	strh r2, [r0, #ACTRT_AX]

	@ update look counter.
	ldr r3, =look_counter
	ldrb r2, [r3]
	cmp r2, #LOOK_TRIGGER
	subgt r2, r2, #1
	strgtb r2, [r3]

	@ update attack counter.
	ldrb r2, [r4, #SAMST_ATTACKCTR]
	cmp r2, #0
	subgt r2, r2, #1
	strgtb r2, [r4, #SAMST_ATTACKCTR]

	@ Decrement invulnerability.
	ldrb r2, [r4, #SAMST_INVULNCTR]
	cmp r2, #0
	subgt r2, r2, #1
	strgtb r2, [r4, #SAMST_INVULNCTR]

	@ Check for death.
	ldr r3, =archetype_table
	ldrh r2, [r0, #ACTRT_TYPE]
	mov r2, r2, lsl #1
	ldrh r2, [r3, r2]
	add r3, r3, r2, lsl #2
	ldr r2, =difficulty_level
	ldrb r2, [r2]
	add r2, r2, #4
	ldrb r3, [r3, r2]

	ldrsb r2, [r0, #ACTRT_HEALTH]
	cmp r2, #0
	rsblt r2, r2, #0
	cmp r2, r3
	blt 1f

	@ Make him dead, Daddy
	ldrb r3, [r0, #ACTRT_FLAGS]
	bic r3, r3, #ACTRT_FLAG_ALIVE
	strb r3, [r0, #ACTRT_FLAGS]

1:	@ update jump counter.
	ldrb r2, [r4, #SAMST_JUMPCTR]
	cmp r2, #1
	blt 7f
	cmp r7, #0
	moveq r2, #1
	subs r2, r2, #1
	strb r2, [r4, #SAMST_JUMPCTR]
	bne 7f
	bl sam_jump

7:	ldrb r2, [r4, #SAMST_WALLCTR]
	cmp r2, #1
	blt 7f
	cmp r8, #0
	moveq r2, #1
	subs r2, r2, #1
	strb r2, [r4, #SAMST_WALLCTR]
	bne 7f
	bl sam_walljump

7:	ldmfd sp!, {r4-r8,lr}
	bx lr
@ EOR human_sam


@ sam_jump
@   makes sam jump.  assumes it will be called from human_sam.
@
sam_jump:
	ldrsh r2, [r0, #ACTRT_VY]
	sub r2, r2, #SAM_JUMP_POWER
	ldrb r3, [r4, #SAMST_JUMPCTR]
	add r2, r2, r3, lsl #SAM_JUMPCTR_SHIFT
	strh r2, [r0, #ACTRT_VY]
	@mov r2, #SAM_JUMP_IMPULSE
	@strh r2, [r0, #ACTRT_VY]

	ldr r5, =actor_segs
	ldrb r3, [r0, #ACTRT_IDX]
	add r5, r5, r3, lsl #2
	mov r2, #0
	strh r2, [r5, #ACTSEG_FLOOR]
	bx lr
@ EOR sam_jump


@ sam_walljump
@   makes sam wall-jump.  assumes it will be called from human_sam.
sam_walljump:
	ldrsh r2, [r0, #ACTRT_VY]
	sub r2, r2, #SAM_WALL_VPOWER
	strh r2, [r0, #ACTRT_VY]
	mov r2, #SAM_WALL_POWER
	ldrb r3, [r4, #SAMST_WALLCTR]
	sub r2, r2, r3, lsl #SAM_WALLCTR_SHIFT

	mov r3, r8
	ldr r5, =linebank
	ldr r5, [r5]
	add r3, r3, r3, lsl #1
	add r5, r5, r3, lsl #2
	ldrb r3, [r5, #SEGRT_TYPE]
	mov r5, #1
	tst r3, #SEGTYPE_FLAG_X
	rsbeq r2, r2, #0
	rsbeq r5, r5, #0
	strh r2, [r0, #ACTRT_AX]
	mov r2, #0
	strh r2, [r0, #ACTRT_VX]

	ldr r5, =actor_segs
	ldrb r3, [r0, #ACTRT_IDX]
	add r5, r5, r3, lsl #2
	mov r2, #0
	strh r2, [r5, #ACTSEG_WALL]
	bx lr
@ EOR sam_walljump


@ offset_sam(actor)
@   Sam's specific offsets.
@   Also updates his animations.
@
	.global offset_sam
offset_sam:
	stmfd sp!, {r4-r8,lr}

	mov r6, #0
	mov r7, #0

	ldr r1, [r0, #ACTRT_STATE]

	@ Here we prep the override register with the appropriate attack
	@ animation if necessary.
	ldrb r8, [r1, #SAMST_ATTACKCTR]
	cmp r8, #0
	beq 1f

	ldrb r8, [r1, #SAMST_FLAGS]
	tst r8, #SAM_FLAG_ATTACKFIST
	moveq r8, #SAM_TOPANM_STRIKELEFT
	movne r8, #SAM_TOPANM_STRIKERIGHT

1:	mov r4, r0
	mov r0, r1

	@ Update animations
        ldr r5, [r4, #ACTRT_PARTSPTR]
        ldrb r3, [r5]
        cmp r3, #0xff               @ inactive
        beq 6f

	ldr r3, =actor_segs
	ldrb r1, [r4, #ACTRT_IDX]
	add r3, r3, r1, lsl #2
	ldrh r1, [r3, #ACTSEG_FLOOR]

	ldr r3, =actor_segs
	ldrb r2, [r4, #ACTRT_IDX]
	add r3, r3, r2, lsl #2
	ldrh r2, [r3, #ACTSEG_WALL]

	@ If Sam is getting hurt, that overrides anything else, and we
	@ just choose his leg state based on floors and walls.
	ldrb r3, [r0, #SAMST_INVULNCTR]
	cmp r3, #0
	beq 4f

	ldrb r3, [r0, #SAMST_FLAGS]

	cmp r1, #0
	bne 1f

	@ in the air
	tst r3, #SAM_FLAG_HITDIRECTION
	bne 3f
	two_part_anim_m SAM_BOTANM_JUMP, SAM_TOPANM_HITFRONT
	bal 5f
3:	two_part_anim_m SAM_BOTANM_JUMP, SAM_TOPANM_HITBACK
5:	sub r6, r6, #8
	bal 6f

	@ on a floor
1:	tst r3, #SAM_FLAG_HITDIRECTION
	bne 3f
	two_part_anim_m SAM_BOTANM_STAND, SAM_TOPANM_HITFRONT
	bal 5f
3:	two_part_anim_m SAM_BOTANM_STAND, SAM_TOPANM_HITBACK
5:	sub r6, r6, #13
	bal 6f

4:	cmp r1, #0
	bne 1f
	cmp r2, #0
	beq 2f

	@ check the type of the normal, to see if we should be climbing
	@ or just bouncing.
	ldr r3, =linebank
	ldr r3, [r3]
	add r2, r2, r2, lsl #1
	add r3, r3, r2, lsl #2
	ldrb r2, [r3, #SEGRT_TYPE]
	tst r2, #SEGTYPE_FLAG_LADDER
	bne 3f

	two_part_anim_m SAM_BOTANM_BOUNCE, SAM_TOPANM_BOUNCE
	sub r6, r6, #13
	bal 6f

3:	@ freeze his climbing animation if he has no vertical velocity
	ldrsh r1, [r4, #ACTRT_VY]
	cmp r1, #0
	beq 3f

	two_part_anim_m SAM_BOTANM_CLIMB, SAM_TOPANM_CLIMB
	sub r6, r6, #10
	bal 6f

3:	two_part_anim_m SAM_BOTANM_CLIMBSTOPPED, SAM_TOPANM_CLIMBSTOPPED
	sub r6, r6, #10
	bal 6f

2:	two_part_anim_with_attack_m SAM_BOTANM_JUMP, SAM_TOPANM_JUMP
	sub r6, r6, #7
	cmp r8, #0
	subne r6, r6, #3
	bal 6f

1:	ldr r3, [r4, #ACTRT_STATE]
	ldrb r1, [r3, #SAMST_FLAGS]
	tst r1, #SAM_FLAG_DUCK
	beq 1f
	two_part_anim_with_attack_m SAM_BOTANM_DUCK, SAM_TOPANM_DUCK
	sub r6, r6, #7
	sub r7, r7, #1
	bal 6f

1:	ldrsh r1, [r4, #ACTRT_AX]
	cmp r1, #0
	beq 5f
	two_part_anim_with_attack_m SAM_BOTANM_WALK, SAM_TOPANM_WALK
	sub r6, r6, #11
	add r7, r7, #3
	@ A check to replace offsets in the case of attacking added by Ret
	@ XXX is this the best way to do this?
	cmp r8, #0
	subne r7, r7, #4
	bal 6f

5:	ldrsh r1, [r4, #ACTRT_VX]
	cmp r1, #0
	beq 5f
	two_part_anim_with_attack_m SAM_BOTANM_SKID, SAM_TOPANM_SKID
	sub r6, r6, #11
	cmp r8, #0
	subne r7, r7, #1
	bal 6f

5:	ldr r3, =look_counter
	ldrb r3, [r3]
	cmp r3, #LOOK_TRIGGER
	beq 5f

	two_part_anim_with_attack_m SAM_BOTANM_STAND, SAM_TOPANM_STAND
	sub r6, r6, #13
	cmp r8, #0
	subne r7, r7, #1
	bal 6f

5:	two_part_anim_with_attack_m SAM_BOTANM_STAND, SAM_TOPANM_LOOK
	sub r6, r6, #13
	cmp r8, #0
	subne r7, r7, #1
	ldrb r0, [r5]
	bl sprite_checklooped
	cmp r0, #1
	ldr r3, =look_counter
	moveq r2, #LOOK_FINISHED
	streqb r2, [r3]

6:

	@ Update offsets.
	mov r0, #0
	ldrb r1, [r4, #ACTRT_NPARTS]
	ldr r3, [r4, #ACTRT_PARTSPTR]

	ldrb r2, [r3]
	cmp r2, #0xff		    @ ignore the sprite if inactive.
	beq 0f

	mov r0, #0
	strb r0, [r3, #2]
	strb r0, [r3, #3]	    @ offset Y
	add r3, r3, #4

	ldrb r2, [r3]
	cmp r2, #0xff
	beq 0f

	ldrb r2, [r4, #ACTRT_FLAGS]
	tst r2, #ACTRT_FLAG_FACING
	rsbne r7, r7, #0
	strb r7, [r3, #2]	    @ offset X
	strb r6, [r3, #3]	    @ offset Y
	strb r7, [r4, #ACTRT_CLIPXOFF]
	strb r6, [r4, #ACTRT_CLIPYOFF]

	ldr r5, [r4, #ACTRT_STATE]
	ldrb r2, [r5, #SAMST_FLAGS]
	tst r2, #SAM_FLAG_DUCK
	beq 1f

	mov r5, #14
	strb r5, [r4, #ACTRT_CLIPW]
	mov r6, #16
	strb r6, [r4, #ACTRT_CLIPH]
	mov r5, #1
	strb r5, [r4, #ACTRT_CLIPXOFF]
        mov r5, #2
        rsb r5, r5, #0
	strb r5, [r4, #ACTRT_CLIPYOFF]
	bal 2f

1:	mov r5, #14
	strb r5, [r4, #ACTRT_CLIPW]
	mov r6, #27
	strb r6, [r4, #ACTRT_CLIPH]
	mov r5, #1
	strb r5, [r4, #ACTRT_CLIPXOFF]
        mov r5, #0
	sub r5, r5, #12
	strb r5, [r4, #ACTRT_CLIPYOFF]

2:	add r3, r3, #4

0:	ldmfd sp!, {r4-r8,lr}
	bx lr
@ EOR offset_sam

@ EOF sam.s
