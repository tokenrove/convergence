

	.section .rodata
	.align

	.global wave_spr 
wave_spr:
	.byte 1,0		    @ nanims

	@ Waving
	.byte 5  		    @ nframes
	.byte 0b10000000	    @ size<<4 | palette

	.word (3<<24) | (spr_r1 - .)
	.word (3<<24) | (spr_r2 - .)
	.word (3<<24) | (spr_r3 - .)
	.word (3<<24) | (spr_r4 - .)
	.word (3<<24) | (spr_r5 - .)
	
	.align

spr_r1: .incbin "ephem/wave/wave1.raw"
spr_r2: .incbin "ephem/wave/wave2.raw"
spr_r3: .incbin "ephem/wave/wave3.raw"
spr_r4: .incbin "ephem/wave/wave4.raw"
spr_r5: .incbin "ephem/wave/wave5.raw"

@ EOF wave.s
