

	.section .rodata
	.align

	.global maude_spr
maude_spr:
	.byte 5,0		    @ nanims

	@ Standing
	.byte 4			    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (25<<24) | (spr_breathe0 - .)
	.word (25<<24) | (spr_breathe1 - .)
	.word (25<<24) | (spr_breathe2 - .)
	.word (25<<24) | (spr_breathe1 - .)

	@ Running
	.byte 4			    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (15<<24) | (spr_walk0 - .)
	.word (15<<24) | (spr_walk1 - .)
	.word (15<<24) | (spr_walk2 - .)
	.word (15<<24) | (spr_walk3 - .)
	.word (15<<24) | (spr_walk4 - .)
	.word (15<<24) | (spr_walk5 - .)
	.word (15<<24) | (spr_walk6 - .)
	.word (15<<24) | (spr_walk7 - .)
	.word (15<<24) | (spr_walk8 - .)
	.word (15<<24) | (spr_walk9 - .)

	@ Yelling
	.byte 1			    @ nframes
	.byte 0b0011000		    @ size<<4 | palette

	.word (15<<24) | (spr_yell0 - .)

	
	@ Getting hit
	.byte 1			    @ nframes
	.byte 0b0011000		    @ size<<4 | palette

	.word (15<<24) | (spr_hit0 - .)
	
	
	@ Attacking
	.byte 1			    @ nframes
	.byte 0b0011000		    @ size<<4 | palette

	.word (15<<24) | (spr_attack0 - .)

	.align

spr_breathe0: .incbin "actors/maude/maude_stand1.raw"
spr_breathe1: .incbin "actors/maude/maude_stand2.raw"
spr_breathe2: .incbin "actors/maude/maude_stand3.raw"
spr_walk0: .incbin "actors/maude/maude_walk1.raw"
spr_walk1: .incbin "actors/maude/maude_walk2.raw"
spr_walk2: .incbin "actors/maude/maude_walk3.raw"
spr_walk3: .incbin "actors/maude/maude_walk4.raw"
spr_walk4: .incbin "actors/maude/maude_walk5.raw"
spr_walk5: .incbin "actors/maude/maude_walk6.raw"
spr_walk6: .incbin "actors/maude/maude_walk7.raw"
spr_walk7: .incbin "actors/maude/maude_walk8.raw"
spr_walk8: .incbin "actors/maude/maude_walk9.raw"
spr_walk9: .incbin "actors/maude/maude_walk10.raw"
spr_yell0: .incbin "actors/maude/maude_yell1.raw"
spr_hit0: .incbin "actors/maude/maude_hit1.raw"
spr_attack0: .incbin "actors/maude/maude_attack1.raw"		



