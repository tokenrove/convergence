

	.section .rodata
	.align

	.global platform_spr 
platform_spr:
	.byte 1,0		    @ nanims

	@ platforming
	.byte 1			    @ nframes
	.byte 0b01100000	    @ size<<4 | palette

	.word (6<<24) | (spr_platform - .)

		
	.align
spr_platform: .incbin "actors/platform/platform.raw"


@ EOF platform.s
