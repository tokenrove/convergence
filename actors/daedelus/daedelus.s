

	.section .rodata
	.align

	.global daedelus_spr 
daedelus_spr:
	.byte 13,0		    @ nanims

	@ 1 Loom
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (30<<24) | (spr_loom0 - .)

	@ 2 standing
	.byte 1         	    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (25<<24) | (spr_stand0 - .)

	@ 3 walk (top)
	.byte 8			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (4<<24) | (spr_walk0 - .)
	.word (4<<24) | (spr_walk1 - .)
	.word (4<<24) | (spr_walk2 - .)
	.word (4<<24) | (spr_walk3 - .)
	.word (4<<24) | (spr_walk4 - .)
	.word (4<<24) | (spr_walk5 - .)
	.word (4<<24) | (spr_walk6 - .)
	.word (4<<24) | (spr_walk7 - .)

	@ 4 climb (top)
	.byte 4			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (10<<24) | (spr_climb0 - .)
	.word (6<<24) | (spr_climb1 - .)
	.word (10<<24) | (spr_climb2 - .)
	.word (6<<24) | (spr_climb3 - .)

	@ 5 jump
	.byte 2			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_jump0 - .)
	.word (6<<24) | (spr_jump1 - .)

	@ 6 bounch
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_bounce0 - .)

	@ 7 Hit from front
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (30<<24) | (spr_hit0 - .)

	@ 8 attack 1
	.byte 3			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (30<<24) | (spr_attack0 - .)
	.word (30<<24) | (spr_attack1 - .)
	.word (30<<24) | (spr_attack2 - .)

	@ 9 dash
	.byte 2			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (6<<24) | (spr_dash0 - .)
	.word (6<<24) | (spr_dash1 - .)


	@ 10 crouch
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (30<<24) | (spr_crouch0 - .)

	@ 11 forward drop
	.byte 3			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (30<<24) | (spr_drop0 - .)
	.word (30<<24) | (spr_drop1 - .)
	.word (30<<24) | (spr_drop2 - .)


	@ 12 uppercutcut
	.byte 2			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (30<<24) | (spr_uppercut0 - .)
	.word (30<<24) | (spr_uppercut1 - .)

	@ 13 on ladder but not climbing (top)
	.byte 1			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (30<<24) | (spr_climb2 - .)

	.align

spr_stand0: .incbin "actors/daedelus/stand1.raw"
spr_walk0: .incbin "actors/daedelus/walk1.raw"
spr_walk1: .incbin "actors/daedelus/walk2.raw"
spr_walk2: .incbin "actors/daedelus/walk3.raw"
spr_walk3: .incbin "actors/daedelus/walk4.raw"
spr_walk4: .incbin "actors/daedelus/walk5.raw"
spr_walk5: .incbin "actors/daedelus/walk6.raw"
spr_walk6: .incbin "actors/daedelus/walk7.raw"
spr_walk7: .incbin "actors/daedelus/walk8.raw"
spr_climb0: .incbin "actors/daedelus/climb1.raw"
spr_climb1: .incbin "actors/daedelus/climb2.raw"
spr_climb2: .incbin "actors/daedelus/climb3.raw"
spr_climb3: .incbin "actors/daedelus/climb4.raw"
spr_jump0: .incbin "actors/daedelus/jump1.raw"
spr_jump1: .incbin "actors/daedelus/jump2.raw"
spr_hit0: .incbin "actors/daedelus/hit1.raw"
spr_loom0: .incbin "actors/daedelus/loom1.raw"
spr_crouch0: .incbin "actors/daedelus/crouch1.raw"
spr_uppercut0: .incbin "actors/daedelus/uppercut1.raw"
spr_uppercut1: .incbin "actors/daedelus/uppercut2.raw"
spr_attack0: .incbin "actors/daedelus/attack1.raw"
spr_attack1: .incbin "actors/daedelus/attack2.raw"
spr_attack2: .incbin "actors/daedelus/attack3.raw"
spr_drop0: .incbin "actors/daedelus/drop1.raw"
spr_drop1: .incbin "actors/daedelus/drop2.raw"
spr_drop2: .incbin "actors/daedelus/drop3.raw"
spr_dash0: .incbin "actors/daedelus/dash1.raw"
spr_dash1: .incbin "actors/daedelus/dash2.raw"
spr_bounce0: .incbin "actors/daedelus/bounce1.raw"

	

@ EOF daedelus.s
