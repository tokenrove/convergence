

	.section .rodata
	.align

	.global sitting_victim_spr 
sitting_victim_spr:
	.byte 1,0		    @ nanims

	@ pondering suicide
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_sitting_victim - .)
		
	
	.align
spr_sitting_victim: .incbin "actors/sitting_victim/b1.raw"



@ EOF sitting_victim.s
