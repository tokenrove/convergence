

	.section .rodata
	.align

	.global glenn_spr 
glenn_spr:
	.byte 4,0		    @ nanims

	@ walking
	.byte 4          	    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_walk1 - .)
	.word (6<<24) | (spr_walk2 - .)
	.word (6<<24) | (spr_walk3 - .)
	.word (6<<24) | (spr_walk4 - .)


	@ punch
	.byte 3          	    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_punch1 - .)
	.word (6<<24) | (spr_punch2 - .)
	.word (6<<24) | (spr_punch3 - .)


	@ hit
	.byte 1          	    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_hit1 - .)


	@ die
	.byte 1          	    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (90<<24) | (spr_die - .)

		
	
	.align
spr_walk1: .incbin "actors/glenn/walk1.raw"
spr_walk2: .incbin "actors/glenn/walk2.raw"
spr_walk3: .incbin "actors/glenn/walk3.raw"
spr_walk4: .incbin "actors/glenn/walk4.raw"
spr_punch1: .incbin "actors/glenn/punch1.raw"
spr_punch2: .incbin "actors/glenn/punch2.raw"
spr_punch3: .incbin "actors/glenn/punch3.raw"
spr_hit1: .incbin "actors/glenn/hit1.raw"
spr_die: .incbin "actors/glenn/die.raw"


@ EOF glenn.s
