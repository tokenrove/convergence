
@ sprite.inc -- sprite manager structures.
@ Convergence
@ Copyright Pureplay Games / 2002
@
@ $Id: sprite.inc,v 1.4 2002/11/21 14:48:22 tek Exp $

@ Format of sprite const entries:  XXX THIS MAY CHANGE SOON
@ 0	byte	number of animations
@ 1	byte	pad
@ nanims * {
@ +0	byte	number of frames
@ +1	byte	ssss pppp
@		s = size (in gba sprite size bitset)
@		p = palette
@ nframes * word
@		dddd dddd  oooo oooo  oooo oooo  oooo oooo
@		d = delay
@		o = offset of raw data
@ }

@ sprite runtime entry
@   0	hword	x
.equ SPRT_X,0
@   2	byte	y
.equ SPRT_Y,2
@   3	byte	lcxx pppp
@		    l = looped?
.equ SPRT_FLAG_LOOPED,  0b10000000
@		    c = collision enabled?
.equ SPRT_FLAG_COLLIDE, 0b01000000
@		    x = unused
@		    p = palette
.equ SPRT_FLAGS,3
@   4	byte	mrxv hxxx  if rotation disabled
@                  f ffff  if rotation enabled
@		    m = mosaic enabled
.equ SPRT_XFLAG_MOSAIC, 1<<7
@		    r = rotation enabled
.equ SPRT_XFLAG_ROTSCALE, 1<<6
@		    x = unused
@		    v = vertical flip
@		    h = horizontal flip
@		    f = rotation field to use
.equ SPRT_XFLAGS,4
@   5	byte	bppa aaaa
@		    b = blend?
@		    p = priority
@		    a = animation idx
.equ SPRT_ANIMIDX,5
@   6	byte	frame idx
.equ SPRT_FRAMEIDX,6
@   7	byte	counter
.equ SPRT_COUNTER,7
@   8	word	sprite const pointer
.equ SPRT_CONST,8
@   12	hword	vram tile idx
.equ SPRT_TILEIDX,12
@   14	hword	anim offset(from const pointer)
.equ SPRT_ANIMOFFSET,14
@   16
@ SPRITE_RT_SIZE specifies the size of the sprite runtime structure.
@ If this is changed, a number of places in the code must be changed, as
@ they directly use <<4 instead of multiplying by its size.
.equ SPRITE_RT_SIZE, 16


@ BITMAP_SIZE should never be larger than 4.  (And even that runs the
@ risk of overflowing, unchecked, into other sprites... 3 is safer)
.equ SPR_BITMAP_SIZE, 4
.equ MAXSPRITES, SPR_BITMAP_SIZE*32

@ EOF sprite.inc vim: syn=asm
