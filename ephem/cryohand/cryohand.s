

	.section .rodata
	.align

	.global cryohand_spr 
cryohand_spr:
	.byte 1,0		    @ nanims

	@ flashing
	.byte 1  		    @ nframes
	.byte 0b00000000	    @ size<<4 | palette

	.word (90<<24) | (spr_r1 - .)
	
	.align

spr_r1: .incbin "ephem/cryohand/cryohand.raw"

@ EOF muz.s
