

	.section .rodata
	.align

	.global juno_spr 
juno_spr:
	.byte 13,0		    @ nanims

	@ 1 standing
	.byte 1         	    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (25<<24) | (spr_stand0 - .)

	@ 2 walk (top)
	.byte 8			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (4<<24) | (spr_walk0 - .)
	.word (4<<24) | (spr_walk1 - .)
	.word (4<<24) | (spr_walk2 - .)
	.word (4<<24) | (spr_walk3 - .)
	.word (4<<24) | (spr_walk4 - .)
	.word (4<<24) | (spr_walk5 - .)
	.word (4<<24) | (spr_walk6 - .)
	.word (4<<24) | (spr_walk7 - .)

	@ 3 climb (top)
	.byte 4			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (10<<24) | (spr_climb0 - .)
	.word (6<<24) | (spr_climb1 - .)
	.word (10<<24) | (spr_climb2 - .)
	.word (6<<24) | (spr_climb3 - .)

	@ 4 jump
	.byte 8			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (6<<24) | (spr_jump0 - .)
	.word (6<<24) | (spr_jump1 - .)

	@ 5 Hit from front
	.byte 1			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (30<<24) | (spr_hit0 - .)

	@ 6 Block
	.byte 1			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (30<<24) | (spr_block0 - .)

	@ 7 punch 1
	.byte 2			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (3<<24) | (spr_punch0 - .)
	.word (6<<24) | (spr_punch1 - .)

	@ 8 punch 2
	.byte 2			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (3<<24) | (spr_punch2 - .)
	.word (6<<24) | (spr_punch3 - .)

	@ 9 duck
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (30<<24) | (spr_duck0 - .)

	@ 10 forward kick
	.byte 2			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (3<<24) | (spr_kick0 - .)
	.word (6<<24) | (spr_kick1 - .)

	@ 11 high kick
	.byte 2			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (3<<24) | (spr_kick2 - .)
	.word (6<<24) | (spr_kick3 - .)

	@ 12 duckkick
	.byte 2			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (3<<24) | (spr_duck1 - .)
	.word (6<<24) | (spr_duck2 - .)

	@ 13 on ladder but not climbing (top)
	.byte 1			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (30<<24) | (spr_climb2 - .)

	.align

spr_stand0: .incbin "actors/juno/stand1.raw"
spr_walk0: .incbin "actors/juno/walk1.raw"
spr_walk1: .incbin "actors/juno/walk2.raw"
spr_walk2: .incbin "actors/juno/walk3.raw"
spr_walk3: .incbin "actors/juno/walk4.raw"
spr_walk4: .incbin "actors/juno/walk5.raw"
spr_walk5: .incbin "actors/juno/walk6.raw"
spr_walk6: .incbin "actors/juno/walk7.raw"
spr_walk7: .incbin "actors/juno/walk8.raw"
spr_climb0: .incbin "actors/juno/climb1.raw"
spr_climb1: .incbin "actors/juno/climb2.raw"
spr_climb2: .incbin "actors/juno/climb3.raw"
spr_climb3: .incbin "actors/juno/climb4.raw"
spr_jump0: .incbin "actors/juno/jump1.raw"
spr_jump1: .incbin "actors/juno/jump2.raw"
spr_hit0: .incbin "actors/juno/hit1.raw"
spr_block0: .incbin "actors/juno/block1.raw"
spr_duck0: .incbin "actors/juno/duck1.raw"
spr_duck1: .incbin "actors/juno/duck2.raw"
spr_duck2: .incbin "actors/juno/duck3.raw"
spr_punch0: .incbin "actors/juno/punch1.raw"
spr_punch1: .incbin "actors/juno/punch2.raw"
spr_punch2: .incbin "actors/juno/punch3.raw"
spr_punch3: .incbin "actors/juno/punch4.raw"
spr_kick0: .incbin "actors/juno/kick1.raw"
spr_kick1: .incbin "actors/juno/kick2.raw"
spr_kick2: .incbin "actors/juno/kick3.raw"
spr_kick3: .incbin "actors/juno/kick4.raw"

	

@ EOF juno.s
