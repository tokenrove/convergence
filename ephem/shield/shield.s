

	.section .rodata
	.align

	.global shield_spr 
shield_spr:
	.byte 1,0		    @ nanims

	@ Dissapating
	.byte 6  		    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (3<<24) | (spr_r1 - .)
	.word (3<<24) | (spr_r2 - .)
	.word (3<<24) | (spr_r3 - .)
	.word (3<<24) | (spr_r4 - .)
	.word (3<<24) | (spr_r3 - .)
	.word (3<<24) | (spr_r2 - .)
	
	.align
	

spr_r1: .incbin "ephem/shield/shield1.raw"
spr_r2: .incbin "ephem/shield/shield2.raw"
spr_r3: .incbin "ephem/shield/shield3.raw"
spr_r4: .incbin "ephem/shield/shield4.raw"

@ EOF shield.s
