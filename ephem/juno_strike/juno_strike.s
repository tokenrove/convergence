

	.section .rodata
	.align

	.global junostrike_spr 
junostrike_spr:
	.byte 5,0		    @ nanims

	@ punch 1
	.byte 3			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (3<<24) | (spr_punch1 - .)
	.word (3<<24) | (spr_punch2 - .)
	.word (3<<24) | (spr_punch3 - .)


	@ punch 2
	.byte 3			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (3<<24) | (spr_punch4 - .)
	.word (3<<24) | (spr_punch5 - .)
	.word (3<<24) | (spr_punch6 - .)


	@ kick 1
	.byte 3			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (3<<24) | (spr_kick1 - .)
	.word (3<<24) | (spr_kick2 - .)
	.word (3<<24) | (spr_kick3 - .)


	@ kick 2
	.byte 3			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (3<<24) | (spr_kick4 - .)
	.word (3<<24) | (spr_kick5 - .)
	.word (3<<24) | (spr_kick6 - .)


	@ duck
	.byte 3			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (3<<24) | (spr_duck1 - .)
	.word (3<<24) | (spr_duck2 - .)
	.word (3<<24) | (spr_duck3 - .)
	

	
	.align

spr_punch1: .incbin "ephem/juno_strike/punch1.raw"
spr_punch2: .incbin "ephem/juno_strike/punch2.raw"
spr_punch3: .incbin "ephem/juno_strike/punch3.raw"
spr_punch4: .incbin "ephem/juno_strike/punch4.raw"
spr_punch5: .incbin "ephem/juno_strike/punch5.raw"
spr_punch6: .incbin "ephem/juno_strike/punch6.raw"

spr_kick1: .incbin "ephem/juno_strike/kick1.raw"
spr_kick2: .incbin "ephem/juno_strike/kick2.raw"
spr_kick3: .incbin "ephem/juno_strike/kick3.raw"
spr_kick4: .incbin "ephem/juno_strike/kick4.raw"
spr_kick5: .incbin "ephem/juno_strike/kick5.raw"
spr_kick6: .incbin "ephem/juno_strike/kick6.raw"

spr_duck1: .incbin "ephem/juno_strike/duck1.raw"
spr_duck2: .incbin "ephem/juno_strike/duck2.raw"
spr_duck3: .incbin "ephem/juno_strike/duck3.raw"





@ EOF strike.s
