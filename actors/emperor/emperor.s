

	.section .rodata
	.align

	.global emperor_top
emperor_top:
	.byte 1,0		    @ nanims

	@ evil
	.byte 4 		    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (6<<24) | (spr_emp0 - .)
	.word (6<<24) | (spr_emp1 - .)
	.word (6<<24) | (spr_emp2 - .)
	.word (6<<24) | (spr_emp1 - .)

	.align

spr_emp0: .incbin "actors/emperor/emptop1.raw"
spr_emp1: .incbin "actors/emperor/emptop2.raw"
spr_emp2: .incbin "actors/emperor/emptop3.raw"


	.global emperor_bot
emperor_bot:
	.byte 1,0		    @ nanims

	@ evil
	.byte 4 		    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (6<<24) | (spr_empb0 - .)
	.word (6<<24) | (spr_empb1 - .)
	.word (6<<24) | (spr_empb2 - .)
	.word (6<<24) | (spr_empb1 - .)

	.align

spr_empb0: .incbin "actors/emperor/empbot1.raw"
spr_empb1: .incbin "actors/emperor/empbot2.raw"
spr_empb2: .incbin "actors/emperor/empbot3.raw"


@ EOF emperor.s
