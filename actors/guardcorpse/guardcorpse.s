

	.section .rodata
	.align

	.global guardcorpse_spr 
guardcorpse_spr:
	.byte 1,0		    @ nanims

	@ deading
	.byte 1			    @ nframes
	.byte 0b01100000	    @ size<<4 | palette

	.word (6<<24) | (spr_guardcorpse - .)
		
	
	.align
spr_guardcorpse: .incbin "actors/guardcorpse/guardcorpse.raw"



@ EOF guardcorpse.s
