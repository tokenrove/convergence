

	.section .rodata
	.align

	.global daedelus_strike_spr 
daedelus_strike_spr:
	.byte 1,0		    @ nanims

	@ fist (Overlay directly)
	.byte 4  		    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (5<<24) | (spr_punch1 - .)
	.word (5<<24) | (spr_punch2 - .)
	.word (5<<24) | (spr_punch3 - .)
	.word (5<<24) | (spr_punch4 - .)

	
	@ uppercut (Overlay directly)
	.byte 4  		    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (5<<24) | (spr_upper1 - .)
	.word (5<<24) | (spr_upper2 - .)
	.word (5<<24) | (spr_upper3 - .)
	.word (5<<24) | (spr_upper4 - .)
	

	@ drop (Overlay directly)
	.byte 4  		    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (5<<24) | (spr_drop1 - .)
	.word (5<<24) | (spr_drop2 - .)
	.word (5<<24) | (spr_drop3 - .)
	.word (5<<24) | (spr_drop4 - .)


	@ dash (offset 8 pixels forward)
	.byte 4  		    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (5<<24) | (spr_dash1 - .)
	.word (5<<24) | (spr_dash2 - .)
	.word (5<<24) | (spr_dash3 - .)
	.word (5<<24) | (spr_dash2 - .)
	

	
	.align

spr_punch1: .incbin "ephem/daedelus_strike/dfist1.raw"
spr_punch2: .incbin "ephem/daedelus_strike/dfist2.raw"
spr_punch3: .incbin "ephem/daedelus_strike/dfist3.raw"
spr_punch4: .incbin "ephem/daedelus_strike/dfist4.raw"

spr_upper1: .incbin "ephem/daedelus_strike/dup1.raw"
spr_upper2: .incbin "ephem/daedelus_strike/dup2.raw"
spr_upper3: .incbin "ephem/daedelus_strike/dup3.raw"
spr_upper4: .incbin "ephem/daedelus_strike/dup4.raw"

spr_drop1: .incbin "ephem/daedelus_strike/ddrop1.raw"
spr_drop2: .incbin "ephem/daedelus_strike/ddrop2.raw"
spr_drop3: .incbin "ephem/daedelus_strike/ddrop3.raw"
spr_drop4: .incbin "ephem/daedelus_strike/ddrop4.raw"

spr_dash1: .incbin "ephem/daedelus_strike/ddash1.raw"
spr_dash2: .incbin "ephem/daedelus_strike/ddash2.raw"
spr_dash3: .incbin "ephem/daedelus_strike/ddash3.raw"

@ EOF daedelus_strike.s
