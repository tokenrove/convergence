

	.section .rodata
	.align

	.global lilly_spr 
lilly_spr:
	.byte 5,0		    @ nanims

	@ 2 walk (top)
	.byte 4			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (4<<24) | (spr_walk0 - .)
	.word (4<<24) | (spr_walk1 - .)
	.word (4<<24) | (spr_walk2 - .)
	.word (4<<24) | (spr_walk1 - .)


	@ 2 fire
	.byte 2			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (30<<24) | (spr_fire0 - .)
	.word (70<<24) | (spr_fire1 - .)
	.word (30<<24) | (spr_fire0 - .)


	@ 3 gets hit (top)
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (30<<24) | (spr_hit1 - .)


	@ 4 gets hit (top)
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (90<<24) | (spr_die1 - .)

	.align

spr_walk0: .incbin "actors/lilly/walk1.raw"
spr_walk1: .incbin "actors/lilly/walk2.raw"
spr_walk2: .incbin "actors/lilly/walk3.raw"
spr_hit1: .incbin "actors/lilly/hit1.raw"
spr_fire0: .incbin "actors/lilly/fire1.raw"
spr_fire1: .incbin "actors/lilly/fire2.raw"
spr_die1: .incbin "actors/lilly/die.raw"



	

@ EOF lilly.s
