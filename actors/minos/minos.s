

	.section .rodata
	.align

	.global minos_spr 
minos_spr:
	.byte 10,0		    @ nanims

	@ 1 loom
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_loom - .)


	@ 2 standing
	.byte 4			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (25<<24) | (spr_stand0 - .)
	.word (25<<24) | (spr_stand1 - .)
	.word (25<<24) | (spr_stand2 - .)
	.word (25<<24) | (spr_stand1 - .)

	@ 3 walk (top)
	.byte 8			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (4<<24) | (spr_walk0 - .)
	.word (4<<24) | (spr_walk1 - .)
	.word (4<<24) | (spr_walk2 - .)
	.word (4<<24) | (spr_walk3 - .)
	.word (4<<24) | (spr_walk4 - .)
	.word (4<<24) | (spr_walk5 - .)
	.word (4<<24) | (spr_walk6 - .)
	.word (4<<24) | (spr_walk7 - .)

	@ 4 climb (top)
	.byte 4			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (10<<24) | (spr_climb0 - .)
	.word (6<<24) | (spr_climb1 - .)
	.word (10<<24) | (spr_climb2 - .)
	.word (6<<24) | (spr_climb3 - .)

	@ 5 jump
	.byte 8			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_jump0 - .)
	.word (6<<24) | (spr_jump1 - .)
	.word (6<<24) | (spr_jump2 - .)
	.word (6<<24) | (spr_jump3 - .)
	.word (6<<24) | (spr_jump4 - .)
	.word (6<<24) | (spr_jump5 - .)
	.word (6<<24) | (spr_jump6 - .)
	.word (6<<24) | (spr_jump7 - .)

	@ 6 Hit from front
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (30<<24) | (spr_hit0 - .)

	@ 7 duck
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (30<<24) | (spr_duck - .)

	@ 8 on ladder but not climbing (top)
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (30<<24) | (spr_climb2 - .)

	@ 9 fire
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (30<<24) | (spr_fire0 - .)

	@ 10 duckfire
	.byte 6			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_duckfire - .)

	@ 11 charge
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (90<<24) | (spr_fire0 - .)


	.align

spr_stand0: .incbin "actors/minos/stand1.raw"
spr_stand1: .incbin "actors/minos/stand2.raw"
spr_stand2: .incbin "actors/minos/stand3.raw"
spr_walk0: .incbin "actors/minos/walk1.raw"
spr_walk1: .incbin "actors/minos/walk2.raw"
spr_walk2: .incbin "actors/minos/walk3.raw"
spr_walk3: .incbin "actors/minos/walk4.raw"
spr_walk4: .incbin "actors/minos/walk5.raw"
spr_walk5: .incbin "actors/minos/walk6.raw"
spr_walk6: .incbin "actors/minos/walk7.raw"
spr_walk7: .incbin "actors/minos/walk8.raw"
spr_climb0: .incbin "actors/minos/climb1.raw"
spr_climb1: .incbin "actors/minos/climb2.raw"
spr_climb2: .incbin "actors/minos/climb3.raw"
spr_climb3: .incbin "actors/minos/climb4.raw"
spr_jump0: .incbin "actors/minos/jump1.raw"
spr_jump1: .incbin "actors/minos/jump2.raw"
spr_jump2: .incbin "actors/minos/jump3.raw"
spr_jump3: .incbin "actors/minos/jump4.raw"
spr_jump4: .incbin "actors/minos/jump5.raw"
spr_jump5: .incbin "actors/minos/jump6.raw"
spr_jump6: .incbin "actors/minos/jump7.raw"
spr_jump7: .incbin "actors/minos/jump8.raw"
spr_hit0: .incbin "actors/minos/hit1.raw"
spr_duckfire: .incbin "actors/minos/duck2.raw"
spr_duck: .incbin "actors/minos/duck1.raw"
spr_fire0: .incbin "actors/minos/fire1.raw"
spr_loom: .incbin "actors/minos/loom1.raw"

	

@ EOF minos.s
