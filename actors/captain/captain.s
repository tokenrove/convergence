

	.section .rodata
	.align

	.global captain_spr 
captain_spr:
	.byte 6,0		    @ nanims

	@ standing
	.byte 1			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (6<<24) | (spr_stand0 - .)

	
	@ walk (top)
	.byte 8			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (6<<24) | (spr_walk0 - .)
	.word (6<<24) | (spr_walk1 - .)
	.word (6<<24) | (spr_walk2 - .)
	.word (6<<24) | (spr_walk3 - .)
	.word (6<<24) | (spr_walk4 - .)
	.word (6<<24) | (spr_walk5 - .)
	.word (6<<24) | (spr_walk6 - .)
	.word (6<<24) | (spr_walk7 - .)

	
	@ fire (top)
	.byte 1			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (6<<24) | (spr_shoot0 - .)


	@ Aim up (top)
	.byte 2			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (6<<24) | (spr_aim0 - .)
	.word (6<<24) | (spr_aim1 - .)


	@ throw (top)
	.byte 2			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (6<<24) | (spr_throw0 - .)
	.word (6<<24) | (spr_throw1 - .)


	@ hit
	.byte 1			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (6<<24) | (spr_hit0 - .)


	@ die
	.byte 1			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (90<<24) | (spr_die1 - .)

	.align
spr_stand0: .incbin "actors/captain/stand1.raw"
spr_walk0: .incbin "actors/captain/walk1.raw"
spr_walk1: .incbin "actors/captain/walk2.raw"
spr_walk2: .incbin "actors/captain/walk3.raw"
spr_walk3: .incbin "actors/captain/walk4.raw"
spr_walk4: .incbin "actors/captain/walk5.raw"
spr_walk5: .incbin "actors/captain/walk6.raw"
spr_walk6: .incbin "actors/captain/walk7.raw"
spr_walk7: .incbin "actors/captain/walk8.raw"
spr_shoot0: .incbin "actors/captain/fire1.raw"
spr_throw0: .incbin "actors/captain/throw1.raw"
spr_throw1: .incbin "actors/captain/throw2.raw"
spr_aim0: .incbin "actors/captain/aim1.raw"
spr_aim1: .incbin "actors/captain/aim2.raw"
spr_hit0: .incbin "actors/captain/hit1.raw"
spr_die1: .incbin "actors/captain/die.raw"

	
@ EOF guard.s
