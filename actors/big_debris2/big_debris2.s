

	.section .rodata
	.align

	.global debris2_spr 
debris2_spr:
	.byte 1,0		    @ nanims

	@ drifting
	.byte 1			    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (6<<24) | (spr_debris2 - .)
		
	
	.align
spr_debris2: .incbin "actors/big_debris2/debris1.raw"


@ EOF debris.s
