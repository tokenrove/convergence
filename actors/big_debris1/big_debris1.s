

	.section .rodata
	.align

	.global debris1_spr 
debris1_spr:
	.byte 1,0		    @ nanims

	@ drifting
	.byte 1			    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (6<<24) | (spr_debris1 - .)
		
	
	.align
spr_debris1: .incbin "actors/big_debris1/debris1.raw"


@ EOF debris.s
