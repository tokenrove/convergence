

	.section .rodata
	.align

	.global sniper_spr 
sniper_spr:
	.byte 9,0		    @ nanims

	@ standing
	.byte 4			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (20<<24) | (spr_stand0 - .)
	.word (20<<24) | (spr_stand1 - .)
	.word (20<<24) | (spr_stand2 - .)
	.word (20<<24) | (spr_stand1 - .)

	
	@ walk (top)
	.byte 8			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_walk0 - .)
	.word (6<<24) | (spr_walk1 - .)
	.word (6<<24) | (spr_walk2 - .)
	.word (6<<24) | (spr_walk3 - .)
	.word (6<<24) | (spr_walk4 - .)
	.word (6<<24) | (spr_walk5 - .)
	.word (6<<24) | (spr_walk6 - .)
	.word (6<<24) | (spr_walk7 - .)


	@ Aim 
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_aim0 - .)

	@ Aim up
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_aim1 - .)

	@ Aim down
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_aim2 - .)


		@ Fire 
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_fire0 - .)

	@ Fire up
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_fire1 - .)

	@ Fire down
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_fire2 - .)


		
	@ hit
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_hit0 - .)

	.align
	
spr_stand0: .incbin "actors/sniper/stand1.raw"
spr_stand1: .incbin "actors/sniper/stand2.raw"
spr_stand2: .incbin "actors/sniper/stand3.raw"
spr_walk0: .incbin "actors/sniper/walk1.raw"
spr_walk1: .incbin "actors/sniper/walk2.raw"
spr_walk2: .incbin "actors/sniper/walk3.raw"
spr_walk3: .incbin "actors/sniper/walk4.raw"
spr_walk4: .incbin "actors/sniper/walk5.raw"
spr_walk5: .incbin "actors/sniper/walk6.raw"
spr_walk6: .incbin "actors/sniper/walk7.raw"
spr_walk7: .incbin "actors/sniper/walk8.raw"
spr_fire0: .incbin "actors/sniper/fires1.raw"
spr_fire1: .incbin "actors/sniper/fireu1.raw"
spr_fire2: .incbin "actors/sniper/fired1.raw"
spr_aim0: .incbin "actors/sniper/aims1.raw"
spr_aim1: .incbin "actors/sniper/aimu1.raw"
spr_aim2: .incbin "actors/sniper/aimd1.raw"
spr_hit0: .incbin "actors/sniper/hit1.raw"

	
@ EOF guard.s
