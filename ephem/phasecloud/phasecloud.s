

	.section .rodata
	.align

	.global phasecloud_spr 
phasecloud_spr:
	.byte 1,0		    @ nanims

	@ Swishshhhh
	.byte 1  		    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (3<<24) | (spr_r1 - .)
	
	.align
	

spr_r1: .incbin "ephem/phasecloud/phasecloud.raw"

@ EOF phasecloud.s
