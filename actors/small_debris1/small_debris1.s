

	.section .rodata
	.align

	.global debris3_spr 
debris3_spr:
	.byte 1,0		    @ nanims

	@ drifting
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_debris3 - .)
		
	
	.align
spr_debris3: .incbin "actors/small_debris1/debris1.raw"


@ EOF debris.s
