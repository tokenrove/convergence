

	.section .rodata
	.align

	.global jewel_spr 
jewel_spr:
	.byte 1,0		    @ nanims

	@ warbling
	.byte 1			    @ nframes
	.byte 0b00000000	    @ size<<4 | palette

	.word (30<<24) | (spr_jewel - .)
	
	.align
spr_jewel: .incbin "osd/jewel.raw"



@ EOF jewel.s
