

	.section .rodata
	.align

	.global vaporize_spr 
vaporize_spr:
	.byte 1,0		    @ nanims

	@ Disintegrate
	.byte 8  		    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (3<<24) | (spr_r1 - .)
	.word (3<<24) | (spr_r2 - .)
	.word (3<<24) | (spr_r3 - .)
	.word (3<<24) | (spr_r4 - .)
	.word (3<<24) | (spr_r5 - .)
	.word (3<<24) | (spr_r6 - .)
	.word (3<<24) | (spr_r7 - .)
	.word (3<<24) | (spr_r8 - .)
	
	.align

spr_r1: .incbin "ephem/vaporize/vapor1.raw"
spr_r2: .incbin "ephem/vaporize/vapor2.raw"
spr_r3: .incbin "ephem/vaporize/vapor3.raw"
spr_r4: .incbin "ephem/vaporize/vapor4.raw"
spr_r5: .incbin "ephem/vaporize/vapor5.raw"
spr_r6: .incbin "ephem/vaporize/vapor6.raw"
spr_r7: .incbin "ephem/vaporize/vapor7.raw"
spr_r8: .incbin "ephem/vaporize/vapor8.raw"

@ EOF vaporize.s
