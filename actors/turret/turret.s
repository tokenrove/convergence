

	.section .rodata
	.align(4)

	.global turret_spr 
turret_spr:
	.byte 2,0		    @ nanims

	@ sitting
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_sit - .)

	
	@ firing
	.byte 4			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_sit - .)
	.word (6<<24) | (spr_fire - .)

	
	.align(4)
spr_sit: .incbin "actors/turret/turret.raw"
spr_fire: .incbin "actors/turret/turret2.raw"


@ EOF turret.s
