

	.section .rodata
	.align

	.global elevator_spr 
elevator_spr:
	.byte 1,0		    @ nanims

	@ sitting
	.byte 1			    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (6<<24) | (spr_elevator - .)
		
	
	.align
spr_elevator: .incbin "actors/elevator/elevator.raw"


@ EOF orb.s
