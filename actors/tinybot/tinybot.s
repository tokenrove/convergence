

	.section .rodata
	.align(4)

	.global tinybot_spr 
tinybot_spr:
	.byte 1,0		    @ nanims

	@ warbling
	.byte 2			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_tinybot - .)
	.word (6<<24) | (spr_tinybot1 - .)
		
	
	.align(4)
spr_tinybot: .incbin "actors/tinybot/t2.raw"
spr_tinybot1: .incbin "actors/tinybot/t1.raw"




@ EOF tinybot.s
