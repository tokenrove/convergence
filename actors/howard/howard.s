

	.section .rodata
	.align

	.global howard_spr 
howard_spr:
	.byte 1,0		    @ nanims

	@ Howarding
	.byte 1 		    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (6<<24) | (spr_howard - .)
		
	.align
spr_howard: .incbin "actors/howard/top1.raw"

	.global howard_end 
howard_end:
	.byte 2,0		    @ nanims

	@ Terrorizing Degrassi High
	.byte 4 		    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (6<<24) | (spr_bottom0 - .)
	.word (6<<24) | (spr_bottom1 - .)
	.word (6<<24) | (spr_bottom2 - .)
	.word (6<<24) | (spr_bottom1 - .)
		
	@ Terrorizing Degrassi High
	.byte 1 		    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (6<<24) | (spr_bottom3 - .)


	.align

spr_bottom0: .incbin "actors/howard/bottom1.raw"
spr_bottom1: .incbin "actors/howard/bottom2.raw"
spr_bottom2: .incbin "actors/howard/bottom3.raw"
spr_bottom3: .incbin "actors/howard/bottoms.raw"




	.global howard_mid 
howard_mid:
	.byte 2,0		    @ nanims

	@ Terrorizing Degrassi High
	.byte 4 		    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (6<<24) | (spr_mid0 - .)
	.word (6<<24) | (spr_mid1 - .)
	.word (6<<24) | (spr_mid2 - .)
	.word (6<<24) | (spr_mid1 - .)

	@ Ichor Spread
	.byte 1 		    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (6<<24) | (spr_mid3 - .)

		
	.align
spr_mid0: .incbin "actors/howard/middle1.raw"
spr_mid1: .incbin "actors/howard/middle2.raw"
spr_mid2: .incbin "actors/howard/middle3.raw"
spr_mid3: .incbin "actors/howard/middles.raw"


@ EOF howard.s
