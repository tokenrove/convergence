@ sprite -- hardware sprite management.
@ Convergence
@ Copyright Pureplay Games / 2002
@
@ $Id: sprite.s,v 1.40 2002/11/27 15:42:53 tek Exp $

@ About this module:
@   The sprite module deals with the allocation and management of
@   hardware sprites, as well as assigning and updating animations for
@   them.  As each record to track (each sprite_rt) is a constant size,
@   we use a bitmap to keep track of free blocks.  The bitmap,
@   obviously, is never larger than 128 bits. (4 words)
@
@   sprite_add() searches for the first bit clear in the bitmap, and
@   allocates that sprite, setting the bit high.
@
@   sprite_remove() checks if the supplied handle is indeed allocated,
@   and clears the bit.  It abort()s if the handle refers to a bit set
@   low.
@
@   sprite_vbl() should be called during vblank.  It traverses the
@   allocation bitmap, and for each bit set, it updates the animation of
@   the corresponding sprite, and DMA copies the current frame to VRAM.
@   It aborts if we run out of space.
@
@ Maximum possible memory usage, currently:
@   MAXSPRITES*SPRITE_RT_SIZE + SPR_BITMAP_SIZE*4
@   64 * 16 + 2*4
@ = 1032 bytes
@
@ BUGS:
@   - bounds checking is minimal at best
@

	.include "sprite.inc"
	.include "gba.inc"
	.include "dma.inc"

	.section .iwram
	.align

	.global sprite_rt, spr_alloc_map, sprite_rotfields
spr_alloc_map: .skip SPR_BITMAP_SIZE*4
sprite_rt: .skip MAXSPRITES*SPRITE_RT_SIZE
sprite_rotfields: .skip MAXSPRITES*2

shadow_oam: .skip 8*128

	.section .text
	.arm
	.align

@ void sprite_init(void)
@   Initializes the sprite manager.
@   Wipes the allocation bitmap and rotation fields clean.
@
	.global sprite_init
sprite_init:
	ldr r0, =spr_alloc_map
	mov r1, #SPR_BITMAP_SIZE
	mov r2, #0
0:	str r2, [r0], #4
	subs r1, r1, #1
	bne 0b

	ldr r0, =sprite_rotfields
	mov r1, #MAXSPRITES*2
	mov r2, #0
0:	str r2, [r0], #4
	subs r1, r1, #4
	bne 0b

	bx lr
@ EOR sprite_init


@ handle sprite_add(sprite, palette)
@   Adds the supplied sprite to the active sprite bitmap, returns
@   its handle.
@
	.global sprite_add
sprite_add:
	stmfd sp!,{r4,lr}

	@ save palette index
	mov r4, r1

	@ save sprite const
	stmfd sp!, {r0}

	@ Find the first free handle.
	ldr r0, =spr_alloc_map
	mov r1, #SPR_BITMAP_SIZE
	mov r2, #0

0:	ldr r3, [r0]
1:	tst r3, #1
	beq 2f
	add r2, r2, #1
	mov r3, r3, lsr #1	    @ next bit
	tst r2, #31		    @ next word when r2&31 = 0
	bne 1b
	add r0, r0, #4
	subs r1, r1, #1
	bne 0b

	@ no free sprites!
#ifndef NDEBUG
	ldr r0, =msg_nofreesprites
	bal abort
#endif
	@ if we got here, debugging is turned off, so we
	@ want to deal with this gracefully... force r2 to
	@ MAXSPRITES - 1
	mov r2, #MAXSPRITES
	sub r2, r2, #1
	sub r0, r0, #4

	@ set this bit in the allocation bitmap
2:	and r3, r2, #31
	mov r1, #1
	mov r1, r1, lsl r3
	ldr r3, [r0]
	orr r3, r3, r1
	str r3, [r0]

	@ Set up this sprite with some ``sane'' default values.
	ldr r0, =sprite_rt
	add r0, r0, r2, lsl #4	    @ XXX SPRITE_RT_SIZE = 16

	mov r1, #23
	strh r1, [r0, #SPRT_X]
	add r1, r1, r2, lsl #4
	strb r1, [r0, #SPRT_Y]

	stmfd sp!, {r0,r2}
	mov r1, r4
	mov r0, r2
	bl dynpal_map
	mov r1, r0
	ldmfd sp!, {r0,r2}
	strb r1, [r0, #SPRT_FLAGS]
	mov r1, #0
	strb r1, [r0, #SPRT_XFLAGS]

	mov r1, #0x40		    @ default priority = 2
	strb r1, [r0, #SPRT_ANIMIDX]
	mov r1, #0
	strb r1, [r0, #SPRT_FRAMEIDX]
	mov r1, #1
	strb r1, [r0, #SPRT_COUNTER]

	ldmfd sp!, {r1}
	str r1, [r0, #SPRT_CONST]

	mov r1, #0
	strh r1, [r0, #SPRT_TILEIDX]
	strh r1, [r0, #SPRT_ANIMOFFSET]

	@ Return handle.
	mov r0, r2
	ldmfd sp!, {r4,lr}
	bx lr
@ EOR sprite_add


@ sprite_remove
@
	.global sprite_remove
sprite_remove:
	stmfd sp!, {lr}
	@ assert(r0 < MAXSPRITES)
#ifndef NDEBUG
	cmp r0, #MAXSPRITES
	ldrge r0, =msg_idxoob
	bge abort
#endif
	ldr r3, =spr_alloc_map
	mov r2, r0, lsr #5
	add r3, r3, r2, lsl #2
	ldr r1, [r3]
	stmfd sp!, {r0}
	and r0, r0, #31
	mov r2, #1
	mov r2, r2, lsl r0
	ldmfd sp!, {r0}
	@ assert((spr_alloc_map[r0 >> 5] & (1 << (r0 & 31))) <> 0)
	tst r1, r2
#ifndef NDEBUG
@	ldreq r0, =msg_notset
@	beq abort
#endif
	beq 2f
	bic r1, r1, r2
	str r1, [r3]

	ldr r3, =sprite_rt
	add r3, r3, r0, lsl #4
	ldrb r3, [r3, #SPRT_FLAGS]
	tst r3, #SPRT_FLAG_COLLIDE
	beq 1f
	stmfd sp!, {r0}
	bl collision_remove
	ldmfd sp!, {r0}

1:	ldr r3, =sprite_rt
	add r3, r3, r0, lsl #4
	ldrb r3, [r3, #SPRT_FLAGS]
	stmfd sp!, {r0}
	and r0, r3, #0x0f
	bl dynpal_unmap
	ldmfd sp!, {r0}

	ldr r3, =sprite_rt
	add r3, r3, r0, lsl #4
	ldrb r3, [r3, #SPRT_XFLAGS]
	tst r3, #0x40
	beq 2f
	stmfd sp!, {r0}
	and r0, r3, #31
	bl rotfield_free
	ldmfd sp!, {r0}

2:	ldmfd sp!, {lr}
	bx lr
@ EOR sprite_remove


@ sprite_getanim(handle)
@   Get the current animation of the sprite indicated by {handle}.
@
	.global sprite_getanim
sprite_getanim:
	@ assert(r0 < MAXSPRITES)
#ifndef NDEBUG
	cmp r0, #MAXSPRITES
	ldrge r0, =msg_idxoob
	bge abort
#endif
	@ XXX assert((spr_alloc_map[r0 >> 5] & (r0 & 31)) <> 0)
	ldr r1, =sprite_rt
	add r1, r1, r0, lsl #4
	ldrb r0, [r1, #SPRT_ANIMIDX]
	and r0, r0, #0b11111
	bx lr
@ EOR sprite_getanim


@ sprite_getmaxanim(handle)
@
	.global sprite_getmaxanim
sprite_getmaxanim:
	@ assert(r0 < MAXSPRITES)
#ifndef NDEBUG
	cmp r0, #MAXSPRITES
	ldrge r0, =msg_idxoob
	bge abort
#endif
	@ XXX assert((spr_alloc_map[r0 >> 5] & (r0 & 31)) <> 0)
	ldr r1, =sprite_rt
	add r1, r1, r0, lsl #4
	ldr r0, [r1, #SPRT_CONST]
	ldrb r0, [r0]
	bx lr
@ EOR sprite_getmaxanim


@ sprite_setanim
@   XXX needs to reset frame counter, etc
@
	.global sprite_setanim
sprite_setanim:
	@ assert(r0 < MAXSPRITES)
#ifndef NDEBUG
	cmp r0, #MAXSPRITES
	ldrge r0, =msg_idxoob
	bge abort
#endif
	@ XXX assert((spr_alloc_map[r0 >> 5] & (r0 & 31)) <> 0)
	ldr r2, =sprite_rt
	add r2, r2, r0, lsl #4
	ldrb r3, [r2, #SPRT_ANIMIDX]
	and r3, r3, #0b11111
	cmp r3, r1
	beq 9f			    @ return immediately if anims are equal
	@ reset loop flag
	ldrb r3, [r2, #SPRT_FLAGS]
	bic r3, r3, #SPRT_FLAG_LOOPED
	strb r3, [r2, #SPRT_FLAGS]
	@ reset frame counter
	ldrb r3, [r2, #SPRT_ANIMIDX]
	bic r3, r3, #0b11111
	orr r3, r3, r1
	strb r3, [r2, #SPRT_ANIMIDX]
	mov r1, #0
	strb r1, [r2, #SPRT_FRAMEIDX]
	@ XXX should reset frame counter to proper delay value here
	mov r1, #1
	strb r1, [r2, #SPRT_COUNTER]
	@ XXX this should check if that anim is out of bounds and
	@ call assert if so.
9:	bx lr
@ EOR sprite_setanim


@ sprite_setpalette
@
	.global sprite_setpalette
sprite_setpalette:
	stmfd sp!, {lr}
	@ assert(r0 < MAXSPRITES)
#ifndef NDEBUG
	cmp r0, #MAXSPRITES
	ldrge r0, =msg_idxoob
	bge abort
#endif
	@ XXX assert((spr_alloc_map[r0 >> 5] & (r0 & 31)) <> 0)
	ldr r2, =sprite_rt
	add r2, r2, r0, lsl #4
	ldrb r3, [r2, #SPRT_FLAGS]
	stmfd sp!, {r0-r2}
	and r0, r3, #0x0f
	bl dynpal_unmap
	ldmfd sp!, {r0-r2}

	stmfd sp!, {r0,r2}
	bl dynpal_map
	mov r1, r0
	ldmfd sp!, {r0,r2}

	ldrb r3, [r2, #SPRT_FLAGS]
	bic r3, r3, #0x0f
	orr r3, r3, r1
	strb r3, [r2, #SPRT_FLAGS]
	ldmfd sp!, {lr}
	bx lr
@ EOR sprite_setpalette


@ sprite_sethvflip
@ XXX should check if we're a rotscale sprite, and do something else if
@	so.  currently, if we're a rotscale sprite, we just leave
@	immediately.
@
	.global sprite_sethvflip
sprite_sethvflip:
	@ assert(r0 < MAXSPRITES)
#ifndef NDEBUG
	cmp r0, #MAXSPRITES
	ldrge r0, =msg_idxoob
	bge abort
#endif
	@ XXX assert((spr_alloc_map[r0 >> 5] & (r0 & 31)) <> 0)
	ldr r2, =sprite_rt
	add r2, r2, r0, lsl #4
	ldrb r3, [r2, #SPRT_XFLAGS]
	tst r3, #0x40
	bne 9f
	bic r3, r3, #0b11000
	orr r3, r3, r1, lsl #3
	strb r3, [r2, #SPRT_XFLAGS]
9:	bx lr
@ EOR sprite_sethvflip


@ sprite_setxy(sprite, x, y)
@
	.global sprite_setxy
sprite_setxy:
	@ assert(r0 < MAXSPRITES)
#ifndef NDEBUG
	cmp r0, #MAXSPRITES
	ldrge r0, =msg_idxoob
	bge abort
#endif
	@ XXX assert((spr_alloc_map[r0 >> 5] & (r0 & 31)) <> 0)
	ldr r3, =sprite_rt
	add r3, r3, r0, lsl #4
	strh r1, [r3, #SPRT_X]
	strb r2, [r3, #SPRT_Y]
	bx lr
@ EOR sprite_setxy


@ sprite_getdimensions(sprite)
@ gets the width and height of the sprite.
@
	.global sprite_getdimensions
sprite_getdimensions:
	@ sprite-size lookup
	ldr r1, =sprite_rt
	add r1, r1, r0, lsl #4
	ldr r0, [r1, #SPRT_CONST]
	ldrh r1, [r1, #SPRT_ANIMOFFSET]
	add r0, r0, r1
	ldrb r0, [r0, #1]
	mov r0, r0, lsr #4
	ldr r1, =size2width_xlat
	mov r2, r0, lsl #1
	ldrh r0, [r1, r2]
	ldr r1, =size2height_xlat
	ldrh r1, [r1, r2]
	bx lr
@ EOR sprite_getdimensions


@ sprite_checklooped(handle)
@   Check if the current animation has looped.
@
	.global sprite_checklooped
sprite_checklooped:
	@ assert(r0 < MAXSPRITES)
#ifndef NDEBUG
	cmp r0, #MAXSPRITES
	ldrge r0, =msg_idxoob
	bge abort
#endif
	@ XXX assert((spr_alloc_map[r0 >> 5] & (r0 & 31)) <> 0)
	ldr r1, =sprite_rt
	add r1, r1, r0, lsl #4
	ldrb r0, [r1, #SPRT_FLAGS]
	tst r0, #SPRT_FLAG_LOOPED
	movne r0, #1
	moveq r0, #0
	bx lr
@ EOR sprite_checklooped


	.section .iwram_code, "ax", %progbits
	.arm
	.align

@ sprite_vbl
@   Update all sprites, during vblank.  For each allocated sprite, we
@   determine their current frame, update their animation, copy their
@   current frame to VRAM, and add an OAM entry for them.
@
	.global sprite_vbl
sprite_vbl:
	stmfd sp!, {r4-r10,lr}

	mov r7, #vram_base
	add r7, r7, #0x10000
	ldr r9, =shadow_oam
	@ walk the allocation bitmap, updating each sprite
	ldr r0, =spr_alloc_map
	mov r1, #SPR_BITMAP_SIZE
	mov r8, #0
	@ find the next set bit
0:	ldr r3, [r0], #4
1:	tst r3, #1
	beq 6f

	stmfd sp!, {r0-r3}	    @ save loop information.
	@ find which frame the sprite is using, copy it to vram
	ldr r5, =sprite_rt
	add r5, r5, r8, lsl #4

	ldr r0, [r5, #SPRT_CONST]
	ldrb r3, [r0], #2	    @ nanims
	ldrb r1, [r5,#SPRT_ANIMIDX]
	and r1, r1, #0b11111
	@ XXX check r1 vs r3 here
	add r1, r1, #1

	@ while(curanim != animidx)...
2:	ldrh r4, [r0], #2	    @ nframes, size, palette
	subs r1, r1, #1
	beq 3f
	@ skip nframes ahead
	and r4, r4, #0xff
	add r0, r0, r4, lsl #2
	b 2b

3:	and r4, r4, #0xff
	mov r4, r7		    @ r7 is the current position in vram
	sub r4, r4, #vram_base
	sub r4, r4, #0x10000
	mov r4, r4, lsr #5
	strh r4, [r5,#SPRT_TILEIDX]

	@ store anim offset.
	ldr r6, [r5, #SPRT_CONST]
	sub r6, r0, r6
	sub r6, r6, #2
	@ XXX assert(r6 > 0)
	strh r6, [r5,#SPRT_ANIMOFFSET]

	ldrb r2, [r5,#SPRT_FRAMEIDX]
	@ check r2 vs r4 here
	add r0, r0, r2, lsl #2

	@ decode frame data offset.
	ldrb r3, [r0]
	ldrb r2, [r0, #1]
	ldrb r1, [r0, #2]
	orr r4, r3, r2, lsl #8
	orr r4, r4, r1, lsl #16
	add r0, r0, r4

	@ figure out how many bytes to copy
	ldrh r2, [r5, #SPRT_ANIMOFFSET]
	ldr r4, [r5, #SPRT_CONST]
	add r4, r4, r2
	ldrb r2, [r4, #1]	    @ size and palette
	mov r2, r2, lsr #4
	ldr r4, =size_xlat
	mov r2, r2, lsl #1
	ldrh r2, [r4, r2]

	@ copy frame to vram, word at a time
	@ XXX assert(r7+r2 < vram_base + 0x17c00)
@	mov r3, r7
@	add r3, r3, r2
@	mov r1, #vram_base
@	add r1, r1, #0x17000
@	cmp r3, r1
@	ldrgt r0, =msg_outofvram
@	bgt abort
	stmfd sp!, {r0-r2}
	@ DMA that motherfucker
	mov r1, r0
	mov r0, r7
	dma_copy32_m
	ldmfd sp!, {r0-r2}
	add r7, r7, r2

	@ set r4 to the address of the current animation.
	ldrh r3, [r5, #SPRT_ANIMOFFSET]
	ldr r4, [r5, #SPRT_CONST]
	add r4, r4, r3

	@
	@ update animations
	@

	ldrb r3, [r5,#SPRT_COUNTER]
	subs r3, r3, #1		    @ decrement the delay counter
	strb r3, [r5,#SPRT_COUNTER]
	bgt 5f

	@ Counter <= 0, so move to the next frame.
	ldrb r3, [r5, #SPRT_FRAMEIDX]
	ldrb r0, [r4]
	add r3, r3, #1
	ldrb r6, [r5, #SPRT_FLAGS]
	cmp r3, r0
	movge r3, #0
	orrge r6, r6, #SPRT_FLAG_LOOPED
	strb r6, [r5, #SPRT_FLAGS]

	@ update the frame idx and reset the delay counter.
	mov r0, r3, lsl #2
	add r0, r0, #5		    @ 2 for frame header, 3 to get the
				    @ last byte from the frame word
	strb r3, [r5, #SPRT_FRAMEIDX]
	ldrb r3, [r4, r0]	    @ delay
	strb r3, [r5, #SPRT_COUNTER]

	@ update hardware sprite
5:	ldrb r2, [r5, #SPRT_Y]
	and r2, r2, #0xff
	ldrb r6, [r4, #1]
	mov r6, r6, lsr #6
	orr r2, r2, r6, lsl #14	    @ top two size bits
	ldrb r6, [r5, #SPRT_ANIMIDX]
	tst r6, #0x80
	orrne r2, r2, #0b01 << 10   @ blend
	ldrb r6, [r5, #SPRT_XFLAGS]
	tst r6, #0x80		    @ mosaic
	orrne r2, r2, #1<<12
	tst r6, #0x40		    @ rotscale (also makes us double-sized)
	orrne r2, r2, #0b11 << 8
	strh r2, [r9], #2	    @ attribute 0

	ldrsh r2, [r5, #SPRT_X]
	mov r6, #0xff
	orr r6, r6, #0x100
	and r2, r2, r6
	ldrb r6, [r4, #1]
	mov r6, r6, lsr #4
	and r6, r6, #0b11
	orr r2, r2, r6, lsl #14	    @ bottom two size bits
	ldrb r6, [r5, #SPRT_XFLAGS] @ rotation field
	and r6, r6, #31
	orr r2, r2, r6, lsl #9
	strh r2, [r9], #2	    @ attribute 1

	ldrh r2, [r5, #SPRT_TILEIDX]
	ldrb r6, [r5, #SPRT_ANIMIDX]
	and r6, r6, #0b01100000
	orr r2, r2, r6, lsl #5
	ldrb r6, [r5, #SPRT_FLAGS]
	and r6, r6, #0b1111
	orr r2, r2, r6, lsl #12
	strh r2, [r9], #2	    @ attribute 2

	mov r2, #0
	strh r2, [r9], #2	    @ attribute 3

	ldmfd sp!, {r0-r3}	    @ restore loop information

6:	@ next bit
	add r8, r8, #1
	movs r3, r3, lsr #1
	bne 1b

	add r8, r8, #31
	bic r8, r8, #31
	subs r1, r1, #1
	bne 0b

	@ Copy shadow OAM to real OAM, sorted by priority
	mov r4, #oam_base
	mov r3, r9
	@ priority 0
	ldr r2, =shadow_oam
0:	ldmia r2!, {r0,r1}
	tst r1, #0b1100 << 8
	stmeqia r4!, {r0,r1}
	cmp r2, r3
	blt 0b
	@ priority 1
	ldr r2, =shadow_oam
0:	ldmia r2!, {r0,r1}
	tst r1, #0b1000 << 8
	bne 1f
	tst r1, #0b0100 << 8
	stmneia r4!, {r0,r1}
1:	cmp r2, r3
	blt 0b
	@ priority 2
	ldr r2, =shadow_oam
0:	ldmia r2!, {r0,r1}
	tst r1, #0b0100 << 8
	bne 1f
	tst r1, #0b1000 << 8
	stmneia r4!, {r0,r1}
1:	cmp r2, r3
	blt 0b
	@ priority 3
	ldr r2, =shadow_oam
0:	ldmia r2!, {r0,r1}
	tst r1, #0b0100 << 8
	beq 1f
	tst r1, #0b1000 << 8
	stmneia r4!, {r0,r1}
1:	cmp r2, r3
	blt 0b

	@ Disable remaining sprites.
	mov r8, #oam_base
	add r8, r8, #1024
	mov r6, #0x200
	mov r7, #0
7:	stmia r4!, {r6,r7}
	cmp r4, r8
	blt 7b

	@ Fill in rotation fields
	mov r4, #oam_base
	add r3, r4, #1024
	ldr r2, =sprite_rotfields
0:	ldrh r1, [r2], #2
	strh r1, [r4, #6]
	add r4, r4, #8
	cmp r4, r3
	blt 0b

	@ Return. (we're out of bits, if we're here.)
	ldmfd sp!, {r4-r10,pc}
@ EOR sprite_vbl

	.section .rodata
	.align

size_xlat: .short 32, 128, 512, 2048
           .short 64, 128, 256, 1024
	   .short 64, 128, 256, 1024
	   .short 0,0,0,0

size2width_xlat: .short 8, 16, 32, 64, 16, 32, 32, 64
                 .short 8, 8, 16, 32, 0,0,0,0

size2height_xlat: .short 8, 16, 32, 64, 8, 8, 16, 32
                  .short 16, 32, 32, 64, 0,0,0,0

msg_nofreesprites: .string "sprite: spr_alloc_map full!"
msg_idxoob: .string "sprite: idx out of bounds"
msg_notset: .string "sprite: bit not set!"

@ EOF sprite.s
