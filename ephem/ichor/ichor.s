

	.section .rodata
	.align

	.global ichor_spr 
ichor_spr:
	.byte 1,0		    @ nanims

	@ dropping
	.byte 1  		    @ nframes
	.byte 0b00000000	    @ size<<4 | palette

	.word (90<<24) | (spr_r1 - .)
	
	.align

spr_r1: .incbin "ephem/ichor/ichor.raw"

@ EOF muz.s
