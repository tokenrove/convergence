

	.section .rodata
	.align

	.global stretcher_spr 
stretcher_spr:
	.byte 1,0		    @ nanims

	@ sitting
	.byte 1			    @ nframes
	.byte 0b01100000	    @ size<<4 | palette

	.word (6<<24) | (spr_stretcher - .)
		
	
	.align
spr_stretcher: .incbin "actors/stretcher/stretch.raw"


@ EOF orb.s
