

	.section .rodata
	.align(4)

	.global beast_spr
beast_spr:
	.byte 1,0		    @ nanims

	@ freaking
	.byte 4			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (15<<24) | (spr_burn0 - .)
	.word (15<<24) | (spr_burn1 - .)
	.word (15<<24) | (spr_burn3 - .)
	.word (15<<24) | (spr_burn2 - .)

	.align

spr_burn0: .incbin "actors/beast/beast1.raw"
spr_burn1: .incbin "actors/beast/beast2.raw"
spr_burn2: .incbin "actors/beast/beast3.raw"
spr_burn3: .incbin "actors/beast/beast4.raw"


