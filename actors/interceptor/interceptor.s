

	.section .rodata
	.align

	.global interceptor_spr 
interceptor_spr:
	.byte 1,0		    @ nanims

	@ warbling
	.byte 3			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_interceptor - .)
	.word (6<<24) | (spr_interceptor1 - .)
	.word (6<<24) | (spr_interceptor2 - .)
		
	
	.align
spr_interceptor: .incbin "actors/interceptor/fly1.raw"
spr_interceptor1: .incbin "actors/interceptor/fly2.raw"
spr_interceptor2: .incbin "actors/interceptor/fly3.raw"



@ EOF interceptor.s
