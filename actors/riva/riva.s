

	.section .rodata
	.align

	.global riva_spr
riva_spr:
	.byte 2,0		    @ nanims

	@ Standing
	.byte 1			    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (25<<24) | (spr_stand0 - .)

	@ Twirl
	.byte 4			    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (3<<24) | (spr_walk0 - .)
	.word (3<<24) | (spr_walk1 - .)
	.word (3<<24) | (spr_walk2 - .)
	.word (3<<24) | (spr_walk3 - .)

	
	.align

spr_stand0: .incbin "actors/riva/mach1.raw"
spr_walk0: .incbin "actors/riva/mach2.raw"
spr_walk1: .incbin "actors/riva/mach3.raw"
spr_walk2: .incbin "actors/riva/mach4.raw"
spr_walk3: .incbin "actors/riva/mach5.raw"



