

	.section .rodata
	.align

	.global balance_meter_spr 
balance_meter_spr:
	.byte 1,0		    @ nanims

	@ warbling
	.byte 1			    @ nframes
	.byte 0b10010000	    @ size<<4 | palette

	.word (30<<24) | (spr_meter - .)
	
	.align
spr_meter: .incbin "osd/meter.raw"



@ EOF meter.s
