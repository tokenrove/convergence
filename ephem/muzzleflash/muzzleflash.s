

	.section .rodata
	.align

	.global muzzleflash_spr 
muzzleflash_spr:
	.byte 1,0		    @ nanims

	@ flashing
	.byte 3  		    @ nframes
	.byte 0b00000000	    @ size<<4 | palette

	.word (1<<24) | (spr_r1 - .)
	.word (1<<24) | (spr_r2 - .)
	.word (1<<24) | (spr_r3 - .)
	
	.align

spr_r1: .incbin "ephem/muzzleflash/muz.raw"
spr_r2: .incbin "ephem/muzzleflash/muz2.raw"
spr_r3: .incbin "ephem/muzzleflash/muz3.raw"

@ EOF muz.s
