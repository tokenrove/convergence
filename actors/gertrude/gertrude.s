

	.section .rodata
	.align

	.global gertrude_spr 
gertrude_spr:
	.byte 2,0		    @ nanims

	@ warbling
	.byte 3			    @ nframes
	.byte 0b01100000	    @ size<<4 | palette

	.word (6<<24) | (spr_gertrude - .)
	.word (6<<24) | (spr_gertrude1 - .)
	.word (6<<24) | (spr_gertrude2 - .)

	
	@ warbling
	.byte 1			    @ nframes
	.byte 0b01100000	    @ size<<4 | palette

	.word (6<<24) | (spr_die - .)

	
	.align
spr_gertrude: .incbin "actors/gertrude/c1.raw"
spr_gertrude1: .incbin "actors/gertrude/c2.raw"
spr_gertrude2: .incbin "actors/gertrude/c3.raw"
spr_die: .incbin "actors/gertrude/die.raw"




@ EOF gertrude.s
