

	.section .rodata
	.align

	.global bigfire_spr 
bigfire_spr:
	.byte 1,0		    @ nanims

	@ FLAMING.
	.byte 15		    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (3<<24) | (spr_bigfire1 - .)
	.word (3<<24) | (spr_bigfire2 - .)
	.word (3<<24) | (spr_bigfire3 - .)
	.word (3<<24) | (spr_bigfire4 - .)
	.word (3<<24) | (spr_bigfire5 - .)
	.word (3<<24) | (spr_bigfire6 - .)
	.word (3<<24) | (spr_bigfire7 - .)
	.word (3<<24) | (spr_bigfire8 - .)
	.word (3<<24) | (spr_bigfire9 - .)
	.word (3<<24) | (spr_bigfire10 - .)
	.word (3<<24) | (spr_bigfire11 - .)
	.word (3<<24) | (spr_bigfire12 - .)
	.word (3<<24) | (spr_bigfire13 - .)
	.word (3<<24) | (spr_bigfire14 - .)
	.word (3<<24) | (spr_bigfire15 - .)
		
	
	.align
spr_bigfire1: .incbin "actors/bigfire/bigfire1.raw"
spr_bigfire2: .incbin "actors/bigfire/bigfire2.raw"
spr_bigfire3: .incbin "actors/bigfire/bigfire3.raw"
spr_bigfire4: .incbin "actors/bigfire/bigfire4.raw"
spr_bigfire5: .incbin "actors/bigfire/bigfire5.raw"
spr_bigfire6: .incbin "actors/bigfire/bigfire6.raw"
spr_bigfire7: .incbin "actors/bigfire/bigfire7.raw"
spr_bigfire8: .incbin "actors/bigfire/bigfire8.raw"
spr_bigfire9: .incbin "actors/bigfire/bigfire9.raw"
spr_bigfire10: .incbin "actors/bigfire/bigfire10.raw"
spr_bigfire11: .incbin "actors/bigfire/bigfire11.raw"
spr_bigfire12: .incbin "actors/bigfire/bigfire12.raw"
spr_bigfire13: .incbin "actors/bigfire/bigfire13.raw"
spr_bigfire14: .incbin "actors/bigfire/bigfire14.raw"
spr_bigfire15: .incbin "actors/bigfire/bigfire15.raw"



@ EOF bigfire.s
