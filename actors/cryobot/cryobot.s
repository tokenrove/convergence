

	.section .rodata
	.align

	.global cryobot_spr
cryobot_spr:
	.byte 1,0		    @ nanims

	@ Intact
	.byte 1			    @ nframes
	.byte 0b00110000		    @ size<<4 | palette

	.word (90<<24) | (spr_intact0 - .)

	
	.align

spr_intact0: .incbin "actors/cryobot/cry1.raw"




