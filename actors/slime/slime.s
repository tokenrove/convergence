

	.section .rodata
	.align

	.global slime_spr 
slime_spr:
	.byte 1,0		    @ nanims

	@ crawling
	.byte 4			    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (25<<24) | (spr_slime1 - .)
	.word (25<<24) | (spr_slime2 - .)
	.word (25<<24) | (spr_slime3 - .)
	.word (25<<24) | (spr_slime2 - .)

		
	
	.align
spr_slime1: .incbin "actors/slime/thead1.raw"
spr_slime2: .incbin "actors/slime/thead2.raw"
spr_slime3: .incbin "actors/slime/thead3.raw"


@ EOF slime.s
