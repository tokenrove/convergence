

	.section .rodata
	.align

	.global scientist_spr 
scientist_spr:
	.byte 3,0		    @ nanims

	@ stand
	.byte 2			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (6<<24) | (spr_stand0 - .)
	.word (6<<24) | (spr_stand1 - .)
	
	@ walk (top)
	.byte 8			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (6<<24) | (spr_walk0 - .)
	.word (6<<24) | (spr_walk1 - .)
	.word (6<<24) | (spr_walk2 - .)
	.word (6<<24) | (spr_walk3 - .)
	.word (6<<24) | (spr_walk4 - .)
	.word (6<<24) | (spr_walk5 - .)
	.word (6<<24) | (spr_walk6 - .)
	.word (6<<24) | (spr_walk7 - .)
	
	@ hit
	.byte 1			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (6<<24) | (spr_hit0 - .)

	.align
	
spr_hit0: .incbin "actors/scientist/hit1.raw"
spr_stand0: .incbin "actors/scientist/stand1.raw"
spr_stand1: .incbin "actors/scientist/stand2.raw"
spr_walk0: .incbin "actors/scientist/walk1.raw"
spr_walk1: .incbin "actors/scientist/walk2.raw"
spr_walk2: .incbin "actors/scientist/walk3.raw"
spr_walk3: .incbin "actors/scientist/walk4.raw"
spr_walk4: .incbin "actors/scientist/walk5.raw"
spr_walk5: .incbin "actors/scientist/walk6.raw"
spr_walk6: .incbin "actors/scientist/walk7.raw"
spr_walk7: .incbin "actors/scientist/walk8.raw"

@ EOF scientist.s
