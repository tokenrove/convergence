

	.section .rodata
	.align

	.global smallexplo_spr 
smallexplo_spr:
	.byte 1,0		    @ nanims

	@ Waving
	.byte 8  		    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (3<<24) | (spr_r1 - .)
	.word (3<<24) | (spr_r2 - .)
	.word (3<<24) | (spr_r3 - .)
	.word (3<<24) | (spr_r4 - .)
	.word (3<<24) | (spr_r5 - .)
	.word (3<<24) | (spr_r6 - .)
	.word (3<<24) | (spr_r7 - .)
	.word (3<<24) | (spr_r8 - .)
	
	.align

spr_r1: .incbin "ephem/smallexplo/explo1.raw"
spr_r2: .incbin "ephem/smallexplo/explo2.raw"
spr_r3: .incbin "ephem/smallexplo/explo3.raw"
spr_r4: .incbin "ephem/smallexplo/explo4.raw"
spr_r5: .incbin "ephem/smallexplo/explo5.raw"
spr_r6: .incbin "ephem/smallexplo/explo6.raw"
spr_r7: .incbin "ephem/smallexplo/explo7.raw"
spr_r8: .incbin "ephem/smallexplo/explo8.raw"

@ EOF smallexplo.s
