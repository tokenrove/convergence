

	.section .rodata
	.align

	.global rescue_spr 
rescue_spr:
	.byte 1,0		    @ nanims

	@ rising
	.byte 1  		    @ nframes
	.byte 0b01010000	    @ size<<4 | palette

	.word (90<<24) | (spr_r1 - .)
	
	.align

spr_r1: .incbin "ephem/rescue/rescue.raw"

@ EOF rescue.s
