

	.section .rodata
	.align

	.global ripper_spr 
ripper_spr:
	.byte 4,0		    @ nanims

	@ standing
	.byte 2			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (16<<24) | (spr_stand0 - .)
	.word (16<<24) | (spr_stand1 - .)

	
	@ jump
	.byte 1			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (6<<24) | (spr_jump0 - .)

	@ rip 
	.byte 3			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_rip0 - .)
	.word (6<<24) | (spr_rip1 - .)
	.word (6<<24) | (spr_rip2 - .)

	@ hit
	.byte 1			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (6<<24) | (spr_hit0 - .)

	
	.align
spr_stand0: .incbin "actors/ripper/stand1.raw"
spr_stand1: .incbin "actors/ripper/stand2.raw"
spr_jump0: .incbin "actors/ripper/jump1.raw"
spr_hit0: .incbin "actors/ripper/hit1.raw"
spr_rip0: .incbin "actors/ripper/attack1.raw"
spr_rip1: .incbin "actors/ripper/attack2.raw"
spr_rip2: .incbin "actors/ripper/attack3.raw"

	
@ EOF ripper.s
