

	.section .rodata
	.align

	.global leaning_victim_spr 
leaning_victim_spr:
	.byte 1,0		    @ nanims

	@ Hucking fries
	.byte 2			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (50<<24) | (spr_leaning_victim - .)
	.word (50<<24) | (spr_leaning_victim2 - .)
		
	
	.align
spr_leaning_victim: .incbin "actors/leaning_victim/b1.raw"
spr_leaning_victim2: .incbin "actors/leaning_victim/b2.raw"



@ EOF leaning_victim.s
