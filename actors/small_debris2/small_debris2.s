

	.section .rodata
	.align

	.global debris4_spr 
debris4_spr:
	.byte 1,0		    @ nanims

	@ drifting
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_debris4 - .)
		
	
	.align
spr_debris4: .incbin "actors/small_debris2/debris1.raw"


@ EOF debris.s
