

	.section .rodata
	.align

	.global health_meter_spr 
health_meter_spr:
	.byte 1,0		    @ nanims

	@ warbling
	.byte 1			    @ nframes
	.byte 0b10010000	    @ size<<4 | palette

	.word (6<<24) | (spr_health - .)
	
	.align
spr_health: .incbin "osd/health.raw"



@ EOF health.s
