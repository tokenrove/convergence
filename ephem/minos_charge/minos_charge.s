

	.section .rodata
	.align

	.global minos_charge_spr 
minos_charge_spr:
	.byte 2,0		    @ nanims

	@ Charging up
	.byte 10  		    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (5<<24) | (spr_r1 - .)
	.word (5<<24) | (spr_r4 - .)
	.word (5<<24) | (spr_r1 - .)
	.word (5<<24) | (spr_r4 - .)
	.word (5<<24) | (spr_r1 - .)
	.word (5<<24) | (spr_r2 - .)
	.word (5<<24) | (spr_r1 - .)
	.word (5<<24) | (spr_r2 - .)
	.word (5<<24) | (spr_r1 - .)
	.word (5<<24) | (spr_r2 - .)

	@ Fully Charged
	.byte 2  		    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (5<<24) | (spr_r2 - .)
	.word (5<<24) | (spr_r3 - .)
	
	.align

spr_r1: .incbin "ephem/minos_charge/mcharge1.raw"
spr_r2: .incbin "ephem/minos_charge/mcharge2.raw"
spr_r3: .incbin "ephem/minos_charge/mcharge3.raw"
spr_r4: .incbin "ephem/minos_charge/mcharge4.raw"

@ EOF mcharge.s
