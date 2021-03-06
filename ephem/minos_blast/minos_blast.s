

	.section .rodata
	.align

	.global minos_blast_spr 
minos_blast_spr:
	.byte 1,0		    @ nanims

	@ Disintegrate
	.byte 10  		    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (3<<24) | (spr_r1 - .)
	.word (3<<24) | (spr_r2 - .)
	.word (3<<24) | (spr_r3 - .)
	.word (3<<24) | (spr_r4 - .)
	.word (3<<24) | (spr_r5 - .)
	.word (3<<24) | (spr_r6 - .)
	.word (3<<24) | (spr_r7 - .)
	.word (3<<24) | (spr_r9 - .)
	.word (3<<24) | (spr_r10 - .)
	.word (3<<24) | (spr_r11 - .)
	.word (3<<24) | (spr_r12 - .)
	
	.align

spr_r1: .incbin "ephem/minos_blast/pain1.raw"
spr_r2: .incbin "ephem/minos_blast/pain2.raw"
spr_r3: .incbin "ephem/minos_blast/pain3.raw"
spr_r4: .incbin "ephem/minos_blast/pain4.raw"
spr_r5: .incbin "ephem/minos_blast/pain5.raw"
spr_r6: .incbin "ephem/minos_blast/pain6.raw"
spr_r7: .incbin "ephem/minos_blast/pain7.raw"
spr_r8: .incbin "ephem/minos_blast/pain8.raw"
spr_r9: .incbin "ephem/minos_blast/pain9.raw"
spr_r10: .incbin "ephem/minos_blast/pain10.raw"
spr_r11: .incbin "ephem/minos_blast/pain11.raw"
spr_r12: .incbin "ephem/minos_blast/pain12.raw"

@ EOF minos_blast.s
