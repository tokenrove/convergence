

	.section .rodata
	.align

	.global sanibot_spr 
sanibot_spr:
	.byte 1,0		    @ nanims

	@ hovering
	.byte 6			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_sanibot1 - .)
	.word (6<<24) | (spr_sanibot2 - .)
	.word (6<<24) | (spr_sanibot3 - .)
	.word (6<<24) | (spr_sanibot4 - .)
	.word (6<<24) | (spr_sanibot5 - .)
	.word (6<<24) | (spr_sanibot6 - .)


		
	
	.align
spr_sanibot1: .incbin "actors/sanibot/sanibot1.raw"
spr_sanibot2: .incbin "actors/sanibot/sanibot2.raw"
spr_sanibot3: .incbin "actors/sanibot/sanibot3.raw"
spr_sanibot4: .incbin "actors/sanibot/sanibot4.raw"
spr_sanibot5: .incbin "actors/sanibot/sanibot5.raw"
spr_sanibot6: .incbin "actors/sanibot/sanibot6.raw"


@ EOF sanibot.s
