

	.section .rodata
	.align

	.global bigexplo_spr 
bigexplo_spr:
	.byte 1,0		    @ nanims

	@ Waving
	.byte 8  		    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (3<<24) | (spr_r1 - .)
	.word (3<<24) | (spr_r2 - .)
	.word (3<<24) | (spr_r3 - .)
	.word (3<<24) | (spr_r4 - .)
	.word (3<<24) | (spr_r5 - .)
	.word (3<<24) | (spr_r6 - .)
	.word (3<<24) | (spr_r7 - .)
	.word (3<<24) | (spr_r8 - .)
	
	.align

spr_r1: .incbin "ephem/bigexplo/explo1.raw"
spr_r2: .incbin "ephem/bigexplo/explo2.raw"
spr_r3: .incbin "ephem/bigexplo/explo3.raw"
spr_r4: .incbin "ephem/bigexplo/explo4.raw"
spr_r5: .incbin "ephem/bigexplo/explo5.raw"
spr_r6: .incbin "ephem/bigexplo/explo6.raw"
spr_r7: .incbin "ephem/bigexplo/explo7.raw"
spr_r8: .incbin "ephem/bigexplo/explo8.raw"

@ EOF bigexplo.s
