@ actor-module wide constants

@ Actor runtime information
@ 0	hword	type
.equ ACTRT_TYPE,0
@ 2	hword	x
.equ ACTRT_X,2
@ 4	hword	y
.equ ACTRT_Y,4
@ 6	hword	horizontal velocity (signed)
.equ ACTRT_VX,6
@ 8	hword	vertical velocity (signed)
.equ ACTRT_VY,8
@ 10	hword	horizontal acceleration (signed)
.equ ACTRT_AX,10
@ 12	hword	vertical acceleration (signed)
.equ ACTRT_AY,12
@ 14	byte	actor idx
.equ ACTRT_IDX,14
@ 15	byte	health
.equ ACTRT_HEALTH,15
@ 16	word	stateptr
.equ ACTRT_STATE,16
@ 20	byte	x delta
.equ ACTRT_XDELTA,20
@ 21	byte	y delta
.equ ACTRT_YDELTA,21
@ 22	byte	xxia swwf
@		x = unused
@               i = slope ignorance
.equ ACTRT_FLAG_SLOPEIGNORE, 1<<5
@		a = alive?
.equ ACTRT_FLAG_ALIVE, 1<<4
@		s = slopeselection
.equ ACTRT_FLAG_SLOPESELECTION, 1<<3
@		w = world (alpha = 01, beta = 10, both = 11)
.equ ACTRT_FLAG_WORLD_ALPHA, 0b0010
.equ ACTRT_FLAG_WORLD_BETA, 0b0100
.equ ACTRT_FLAG_WORLD_MASK, 0b0110
.equ ACTRT_FLAG_WORLD_SHIFT, 1
@		f = facing (right = 0, left = 1)
@		NOTE: this flag _must_ be in this position.
.equ ACTRT_FLAG_FACING, 1
.equ ACTRT_FLAGS,22
@ 23	byte	nparts
.equ ACTRT_NPARTS,23
@ 24	word	pointer to parts array
.equ ACTRT_PARTSPTR,24
@ parts {
@ +0	byte	handle (0xff = no active sprite)
@ +1	byte	xxxx xxxc
@		x = unused
@		c = collidable?
@ +2	byte	x offset (signed)
@ +3	byte	y offset (signed)
@ }
@ 28	byte	(signed) collision rectangle x offset
.equ ACTRT_CLIPXOFF,28
@ 29	byte	collision rectangle width
.equ ACTRT_CLIPW,29
@ 30	byte	(signed) collision rectangle y offset
.equ ACTRT_CLIPYOFF,30
@ 31	byte	collision rectangle height
.equ ACTRT_CLIPH,31
@ 32		XXX if this size ever changes, watch out for references to
@		lsl #5 in the code where a multiply by ACTRT_SIZE should
@		be.
.equ ACTRT_SIZE,32


@ Actor segment information
.equ ACTSEG_FLOOR,0
.equ ACTSEG_WALL,2


@ Damage types
.equ DAMAGE_PHASIC,	0
.equ DAMAGE_BLUDGEON,	1
.equ DAMAGE_SLASH,	2
@ bullets are considered piercing damage
.equ DAMAGE_PIERCE,	3
.equ DAMAGE_FIRE,	5
@ Environmental damage is not attributed to other types.
.equ DAMAGE_ENVIRONMENT,6
@ The Fist of Fury type is actually a modifier bit that determines
@ whether this is part of a furious Hong Kong combo, which causes the
@ recipient to not fly back until the last strike.
.equ DAMAGE_FIST_OF_FURY, 128

@ EOF actor.inc vim: syn=asm
