

	.section .rodata
	.align

	.global worm_spr 
worm_spr:
	.byte 1,0		    @ nanims

	@ crawling
	.byte 4			    @ nframes
	.byte 0b01010000	    @ size<<4 | palette

	.word (6<<24) | (spr_worm1 - .)
	.word (6<<24) | (spr_worm2 - .)
	.word (6<<24) | (spr_worm3 - .)
	.word (6<<24) | (spr_worm2 - .)

		
	
	.align
spr_worm1: .incbin "actors/worm/worm1.raw"
spr_worm2: .incbin "actors/worm/worm2.raw"
spr_worm3: .incbin "actors/worm/worm3.raw"


@ EOF worm.s
