

	.section .rodata
	.align
	
	.global orbiter1_spr 

orbiter1_spr:
	.byte 1,0		    @ nanims

	@ floating
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_orbiter1 - .)


	.global orbiter2_spr 

	
orbiter2_spr:
	.byte 1,0		    @ nanims

	@ floating
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_orbiter2 - .)
		
	
	.align

spr_orbiter1: .incbin "actors/orbiter/d1.raw"
spr_orbiter2: .incbin "actors/orbiter/d2.raw"	




@ EOF orbiter.s
