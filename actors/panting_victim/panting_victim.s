

	.section .rodata
	.align

	.global panting_victim_spr 
panting_victim_spr:
	.byte 1,0		    @ nanims

	@ Removing ketchup stains
	.byte 2			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (50<<24) | (spr_panting_victim - .)
	.word (50<<24) | (spr_panting_victim2 - .)
		
	
	.align
spr_panting_victim: .incbin "actors/panting_victim/b1.raw"
spr_panting_victim2: .incbin "actors/panting_victim/b2.raw"



@ EOF panting_victim.s
