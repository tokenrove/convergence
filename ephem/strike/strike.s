

	.section .rodata
	.align

	.global samstrike_spr 
samstrike_spr:
	.byte 2,0		    @ nanims

	@ right
	.byte 6			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (3<<24) | (spr_r1 - .)
	.word (3<<24) | (spr_r2 - .)
	.word (3<<24) | (spr_r3 - .)
	.word (3<<24) | (spr_r4 - .)
	.word (3<<24) | (spr_r5 - .)
	.word (3<<24) | (spr_r6 - .)


	
	@ left
	.byte 6			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (3<<24) | (spr_l1 - .)
	.word (3<<24) | (spr_l2 - .)
	.word (3<<24) | (spr_l3 - .)
	.word (3<<24) | (spr_l4 - .)
	.word (3<<24) | (spr_l5 - .)
	.word (3<<24) | (spr_l6 - .)

	
	.align

spr_r1: .incbin "ephem/strike/str1.raw"
spr_r2: .incbin "ephem/strike/str2.raw"
spr_r3: .incbin "ephem/strike/str3.raw"
spr_r4: .incbin "ephem/strike/str4.raw"
spr_r5: .incbin "ephem/strike/str5.raw"
spr_r6: .incbin "ephem/strike/str6.raw"

spr_l1: .incbin "ephem/strike/stl1.raw"
spr_l2: .incbin "ephem/strike/stl2.raw"
spr_l3: .incbin "ephem/strike/stl3.raw"
spr_l4: .incbin "ephem/strike/stl4.raw"
spr_l5: .incbin "ephem/strike/stl5.raw"
spr_l6: .incbin "ephem/strike/stl6.raw"




@ EOF strike.s
