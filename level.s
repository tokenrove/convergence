@ level -- level (in-game state) management.
@ Convergence
@ Copyright Pureplay / 2002
@
@ $Id: level.s,v 1.40 2002/12/12 19:38:21 tek Exp $

@ Note: Do not use bank 0 in your tilesets unless you really know what
@   you're doing.  The map data is stored in the lower 8k or so of that
@   bank, so any low tile index references will result in rather odd
@   looking tiles.
@
@ Note: a widely applied optimization within this file is that the
@   number of layers in any of the modes we support is equal to
@   4 - mode.

@ Provisions for compression:
@   tile data can be heavily compressed, as it only needs to be
@   decompressed when the level is loaded, and can then be dumped into
@   EWRAM, and loaded from there into VRAM as world switches occur.
@
@   map data needs to be compressed in a stripwise fasion so that it can
@   be incrementally loaded.  A 32x32 chunk will be decompressed into
@   VRAM for each world, with background registers changed as world
@   switches occur.  As the world scrolls, progressive strips will be
@   decompressed and loaded.
@

@ level format:
@ 0	hword	xxxx xxxx mmtt cccc
@		x = unused
@		m = mode
@		t = number of tilesets
@		c = collidable bits for each layer
@		    lsb is (hardware) layer 0
@ 2	byte	pad
@ 3	byte	number of actors
@ <function pointer extensions would go here>
@ 4	512	palette for alpha world
@ 516	512	palette for beta world
@
@ tilesets: (ntilesets*2, alpha tilesets followed by beta tilesets)
@ +0	hword	bbcs xxnn  nnnn nnnn
@		b = bank
@		c = tiles are 256 color (16 color by default)
@		s = tiles begin 8k into the bank
@		x = unused
@		n = number of tiles
@ +2	hword	pad
@ +4	n*(c+1)*8*8
@		tile data
@
@ layers: (alpha layers followed by beta layers, 0 up to 3 depending on
@          mode)
@ +0	hword	width (in tiles)
@ +2	hword	height (in tiles)
@ NOTE: width or height = 0 indicates that this layer is disabled.
@ +4	byte	bbpp rmmm
@		b = tile bank
@		p = priority
@		r = tiles are for scalerot map, so they are 8-bit
@		    (default: tiles are 16-bit)
@		m = map bank (beta banks begin at 4)
@ +5	byte	scroll speed (numerator of fraction n/128)
@ +6    byte    xxxx xxvh
@               x = unused
@               v = loop vertically
@               h = loop horizontally
@ +7	byte    pad
@	w*h*(2-r)
@		map data
@ <word align>
@
@ actors:
@ +0	hword	type
@ +2	byte	spare
@ +3	byte	txww xenh
@		t = this actor is marked for a trigger, using spare byte
@		x = unused
@		w = world presence
@		    01 -> alpha, 10 -> beta,
@		    11 -> both (only for dual-phase creatures)
@		e = this actor present on easy
@		n = this actor present on normal
@		h = this actor present on difficult
@ +4	hword	x
@ +6	hword	y
@ +8	byte	statesize
@ +9	?	state
@ <word align>


	.include "game.inc"
	.include "actor.inc"

.equ MAXTRIGGERS, 64
.equ MAXTRIGACTORS, 16

	.section .ewram
	.align

	.global balance_instability, stability_counter
n_triggers: .skip 1
balance_instability: .skip 1
stability_counter: .skip 2

trigactors: .skip MAXTRIGACTORS
triggers: .skip MAXTRIGGERS*8

        .global trigger_counter, hero_type
trigger_counter: .skip 1
hero_type: .skip 2
.align


	.section .text
	.arm
	.align

@ level_init
@   Wipes out some of the trigger structures and such.
@
	.global level_init
level_init:
	ldr r0, =n_triggers
	mov r1, #0
	strb r1, [r0]

	ldr r0, =trigactors
	ldr r1, =0xffffffff
	mov r2, #MAXTRIGACTORS
0:	str r1, [r0], #4
	subs r2, r2, #4
	bne 0b
	bx lr
@ EOR level_init


@ level_load(current part of quest)
@
	.global level_load
level_load:
	stmfd sp!, {r4-r6,lr}

        bl string_skip              @ skip the level name.

	@ Save the level pointer.
	mov r5, r0		    @ save the quest pointer for later.
	ldr r0, [r0]
	bl layer_initialize
	mov r4, r0

	@ add the hero.
	add r0, r5, #4
        ldr r1, =hero_type
        ldrh r2, [r0]
        strh r2, [r1]
	bl actor_add    
	ldr r1, =hero_handle	    @ save the hero's handle.
	strb r0, [r1]

	@ add in-level actors
	ldr r0, [r5]
	ldrb r6, [r0, #3]
	cmp r6, #0
	beq 5f
@ {
3:	@ check difficulty
	ldr r0, =difficulty_level
	ldrb r0, [r0]
        rsb r0, r0, #DIFF_HARD
	mov r1, #1
	mov r0, r1, lsl r0
	ldrb r1, [r4, #3]
	tst r1, r0
	beq 4f

	mov r0, r4
	bl actor_add

	@ check for trigger id
	ldrb r1, [r4, #3]
	tst r1, #1<<7
	beq 4f
	ldrb r1, [r4, #2]
	ldr r2, =trigactors
	strb r0, [r2, r1]

4:	add r4, r4, #8
	ldrb r0, [r4], #1
	add r4, r4, r0
	add r4, r4, #3
	bic r4, r4, #0b11
	subs r6, r6, #1
	bne 3b
@ }
5:

	@ skip hero
	add r5, r5, #4
	add r5, r5, #8
	ldrb r1, [r5], #1
	add r5, r5, r1
	add r5, r5, #3
	bic r5, r5, #0b11

        @ trigger counter
        ldrb r0, [r5, #1]
        ldr r1, =trigger_counter
        strb r0, [r1]

	@ load music
	ldrb r0, [r5]		    @ music idx
        ldr r4, =music_table
        add r4, r4, r0, lsl #2
        ldr r4, [r4]
        ldmia r4!, {r0-r3}
        bl music_set_instruments
        ldr r0, [r4], #4
        bl music_play_song

	@ setup stability system
	ldr r2, =difficulty_level
	ldrb r2, [r2]
	add r2, r2, #5
	ldrb r1, [r5, r2]
	ldr r2, =balance_instability
	strb r1, [r2]
	mov r1, #0
	ldr r2, =stability_counter
	strh r1, [r2]

	@ add triggers
	mov r4, r5
	ldrb r6, [r4, #2]
	add r4, r4, #8
	ldr r0, =n_triggers
	strb r6, [r0]
	cmp r6, #MAXTRIGGERS
	movge r0, r6
	bge abort_digits
	ldr r3, =triggers
	cmp r6, #0
	beq 2f
1:	@ check difficulty
	ldr r0, =difficulty_level
	ldrb r0, [r0]
	mov r1, #1
	mov r0, r1, lsl r0
	ldrb r1, [r4]
	mov r1, r1, lsr #4
	tst r1, r0
	beq 4f

	ldmia r4!, {r0-r2}
	stmia r3!, {r0-r2}
4:	subs r6, r6, #1
	bne 1b

2:	@ add any special actors
	ldrb r6, [r5, #3]
	ldrb r2, [r5, #2]
	add r5, r5, #8
	add r2, r2, r2, lsl #1
	add r5, r5, r2, lsl #2	    @ skip triggers

	mov r4, r5
	cmp r6, #0
	beq 5f
@ {
3:	@ check difficulty
	ldr r0, =difficulty_level
	ldrb r0, [r0]
        rsb r0, r0, #DIFF_HARD
	mov r1, #1
	mov r0, r1, lsl r0
	ldrb r1, [r4, #3]
	tst r1, r0
	beq 4f

	mov r0, r4
	bl actor_add

	@ check for trigger id
	ldrb r1, [r4, #3]
	tst r1, #1<<7
	beq 4f
	ldrb r1, [r4, #2]
	ldr r2, =trigactors
	strb r0, [r2, r1]

4:	add r4, r4, #8
	ldrb r0, [r4], #1
	add r4, r4, r0
	add r4, r4, #3
	bic r4, r4, #0b11
	subs r6, r6, #1
	bne 3b
@ }
5:

	@ enter whatever world our hero is in
	ldr r4, =actor_rt
	ldr r0, =hero_handle
	ldrb r0, [r0]
	add r4, r4, r0, lsl #5
        ldrh r0, [r4, #ACTRT_FLAGS]
        tst r0, #ACTRT_FLAG_WORLD_ALPHA
        movne r0, #0
        moveq r0, #1
        ldr r1, =desired_world
        strb r0, [r1]
	@ this will deal with setting up background registers
	@ and copying in current actors.
        mov r0, #0
        ldr r1, =layer_set_world
        mov lr, pc
        mov pc, r1

	ldr r0, =hero_handle
	ldrb r0, [r0]
	bl actor_setcamerafocus

	ldr r0, =camera_x
	ldrh r0, [r0]
	ldr r1, =camera_y
	ldrh r1, [r1]
	mov r2, #0
	bl layer_jumpcamera

	ldr r0, =camera_x
	ldrh r0, [r0]
	ldr r1, =camera_y
	ldrh r1, [r1]
	mov r2, #1
	bl layer_jumpcamera

	ldmfd sp!, {r4-r6,lr}
	bx lr
@ EOR level_load


@ level_checktriggers
@   Checks triggers.  Returns appropriate outcome values or 0 if no
@   trigger occurred.
@
	.global level_checktriggers
level_checktriggers:
	stmfd sp!, {r4-r8,lr}
	ldr r4, =actor_rt
	ldr r0, =hero_handle
	ldrb r0, [r0]
	add r4, r4, r0, lsl #5

	ldrh r5, [r4, #ACTRT_X]
	ldrsb r0, [r4, #ACTRT_CLIPXOFF]
	add r5, r5, r0
	ldrb r0, [r4, #ACTRT_CLIPW]
	add r6, r5, r0

	ldrh r7, [r4, #ACTRT_Y]
	ldrsb r0, [r4, #ACTRT_CLIPYOFF]
	add r7, r7, r0
	ldrb r0, [r4, #ACTRT_CLIPH]
	add r8, r7, r0

	ldr r0, =n_triggers
	ldrb r1, [r0]
	cmp r1, #0
	moveq r0, #0
	beq 9f

	ldr r0, =triggers
0:	ldrb r2, [r0]
	ldrb r3, [r0, #3]

	and r2, r2, #0x0f
	cmp r2, #TR_RECTANGLE
	bne 1f
	tst r3, #TR_HERO	    @ no support for non-hero rectangles yet
	beq 7f

	ldrh r2, [r0, #4]
	ldrh r3, [r0, #6]

	cmp r2, r5
	movlt r2, r5
	cmp r3, r6
	movgt r3, r6
	cmp r3, r2
	blt 7f

	ldrh r2, [r0, #8]
	ldrh r3, [r0, #10]

	cmp r2, r7
	movlt r2, r7
	cmp r3, r8
	movgt r3, r8
	cmp r3, r2
	blt 7f

	@ success

        @ counter dependent?
        ldrb r3, [r0, #3]
        tst r3, #TR_COUNTER_DEPENDENT
        beq 2f

        ldr r3, =trigger_counter
        ldrb r3, [r3]
        cmp r3, #0
        bne 7f

2:	ldrb r2, [r0, #1]
	ldrb r1, [r0, #2]

	@ XXX here we should check if r2 is just something trivial, like
	@ drag, and not break out of the loop, if so.
	mov r0, r2
	bal 8f

1:	cmp r2, #TR_ACTORLIVE
	bne 1f

	ldr r2, =trigactors
	ldrb r3, [r2, r3]
	cmp r3, #0xff
	beq 7f

	ldr r2, =actor_rt
	add r2, r2, r3, lsl #5
	ldrb r3, [r2, #ACTRT_FLAGS]
	tst r3, #ACTRT_FLAG_ALIVE
	bne 7f

	@ success
	ldrb r2, [r0, #1]
	ldrb r1, [r0, #2]

	@ XXX here we should check if r2 is just something trivial, like
	@ drag, and not break out of the loop, if so.
	mov r0, r2
	bal 8f

1:

7:	add r0, r0, #12
	subs r1, r1, #1
	bne 0b

	mov r0, #0
	bal 9f

8:	cmp r0, #TR_NEXTAREA
	bne 1f

	ldr r1, =cur_area
	ldrb r1, [r1]
	add r1, r1, #1
	mov r0, #OUTCOME_AREACHANGE
	bal 9f

1:	cmp r0, #TR_PREVAREA
	bne 1f

	ldr r1, =cur_area
	ldrb r1, [r1]
	sub r1, r1, #1
	mov r0, #OUTCOME_AREACHANGE
	bal 9f

1:	cmp r0, #TR_NEXTLEVEL
	bne 1f

	ldr r1, =cur_area
	ldrb r1, [r1]
	add r1, r1, #1
	mov r0, #OUTCOME_LEVELCHANGE
	bal 9f

1:	cmp r0, #TR_DEATH
	bne abort_digits

	mov r0, #OUTCOME_DEAD

9:	ldmfd sp!, {r4-r8,lr}
	bx lr
@ EOR level_checktriggers

@ EOF level.s
