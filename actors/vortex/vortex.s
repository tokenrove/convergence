

	.section .rodata
	.align

	.global vortex_spr 
vortex_spr:
	.byte 1,0		    @ nanims

	@ warbling
	.byte 8			    @ nframes
	.byte 0b10110000	    @ size<<4 | palette

	.word (6<<24) | (spr_vortex1 - .)
	.word (6<<24) | (spr_vortex2 - .)
	.word (6<<24) | (spr_vortex3 - .)
	.word (6<<24) | (spr_vortex4 - .)
	.word (6<<24) | (spr_vortex5 - .)
	.word (6<<24) | (spr_vortex6 - .)
	.word (6<<24) | (spr_vortex7 - .)
	.word (6<<24) | (spr_vortex8 - .)
		
	
	.align

spr_vortex1: .incbin "actors/vortex/vortex1.raw"
spr_vortex2: .incbin "actors/vortex/vortex2.raw"
spr_vortex3: .incbin "actors/vortex/vortex3.raw"
spr_vortex4: .incbin "actors/vortex/vortex4.raw"
spr_vortex5: .incbin "actors/vortex/vortex5.raw"
spr_vortex6: .incbin "actors/vortex/vortex6.raw"
spr_vortex7: .incbin "actors/vortex/vortex7.raw"
spr_vortex8: .incbin "actors/vortex/vortex8.raw"
spr_vortexg0: .incbin "actors/vortex/grow0.raw"
spr_vortexg1: .incbin "actors/vortex/grow1.raw"




@ EOF vortex.s
