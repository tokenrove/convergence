

	.section .rodata
	.align(4)

	.global drone_spr 
drone_spr:
	.byte 1,0		    @ nanims

	@ hover
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_drone - .)

	
	.align(4)
spr_drone: .incbin "actors/drone/drone_body.raw"

	.global drone_arm_spr 
drone_arm_spr:
	.byte 1,0		    @ nanims

	@ aim
	.byte 1			    @ nframes
	.byte 0b01100000	    @ size<<4 | palette

	.word (6<<24) | (spr_drarm - .)

	
	.align(4)
spr_drarm: .incbin "actors/drone/drone_arm.raw"


@ EOF drone.s
