

	.section .rodata
	.align(4)

	.global orb_spr 
orb_spr:
	.byte 1,0		    @ nanims

	@ warbling
	.byte 7			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_orb - .)
	.word (6<<24) | (spr_orb1 - .)
	.word (6<<24) | (spr_orb2 - .)
	.word (6<<24) | (spr_orb3 - .)
	.word (6<<24) | (spr_orb4 - .)
	.word (6<<24) | (spr_orb5 - .)
	.word (6<<24) | (spr_orb6 - .)
		
	
	.align(4)
spr_orb: .incbin "actors/orb/orb.raw"
spr_orb1: .incbin "actors/orb/orb1.raw"
spr_orb2: .incbin "actors/orb/orb2.raw"
spr_orb3: .incbin "actors/orb/orb3.raw"
spr_orb4: .incbin "actors/orb/orb4.raw"
spr_orb5: .incbin "actors/orb/orb5.raw"
spr_orb6: .incbin "actors/orb/orb6.raw"



@ EOF orb.s
