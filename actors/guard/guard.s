

	.section .rodata
	.align

	.global guard_spr 
guard_spr:
	.byte 14,0		    @ nanims

	@ standing
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (25<<24) | (spr_stand0 - .)


	@ walk (top)
	.byte 8			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (4<<24) | (spr_walk1 - .)
	.word (4<<24) | (spr_walk2 - .)
	.word (4<<24) | (spr_walk3 - .)
	.word (4<<24) | (spr_walk4 - .)
	.word (4<<24) | (spr_walk3 - .)
	.word (4<<24) | (spr_walk2 - .)
	.word (4<<24) | (spr_walk1 - .)
	.word (4<<24) | (spr_walk0 - .)


	@ climb (top)
	.byte 4			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (10<<24) | (spr_climb0 - .)
	.word (6<<24) | (spr_climb1 - .)
	.word (10<<24) | (spr_climb2 - .)
	.word (6<<24) | (spr_climb3 - .)


	@ jump
	.byte 2			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (32<<24) | (spr_jump0 - .)
	.word (32<<24) | (spr_jump1 - .)

	
	@ Hit from front
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (30<<24) | (spr_hit0 - .)


	@ skid
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (30<<24) | (spr_stand0 - .)


	@ duck
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (30<<24) | (spr_stand0 - .)


	@ on ladder but not climbing (top)
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_climb2 - .)


	@ die
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (90<<24) | (spr_die0 - .)


	@ fire forward
	.byte 2			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (5<<24) | (spr_fire0 - .)
	.word (5<<24) | (spr_stand0 - .)
	

	@ aim up fire
	.byte 2			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (5<<24) | (spr_aim0 - .)
	.word (5<<24) | (spr_aim0 - .)
	
	
	@ aim up
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (90<<24) | (spr_aim0 - .)


	@ throw
	.byte 3			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (10<<24) | (spr_throw0 - .)
	.word (10<<24) | (spr_throw1 - .)
	.word (10<<24) | (spr_throw2 - .)

	@ aim down fire
	.byte 2			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (5<<24) | (spr_daim0 - .)
	.word (5<<24) | (spr_daim1 - .)
	
	
	@ aim up
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (90<<24) | (spr_daim0 - .)
	.align

spr_stand0: .incbin "actors/guard/stand_top1.raw"
spr_walk0: .incbin "actors/guard/walk_top1.raw"
spr_walk1: .incbin "actors/guard/walk_top2.raw"
spr_walk2: .incbin "actors/guard/walk_top3.raw"
spr_walk3: .incbin "actors/guard/walk_top4.raw"
spr_walk4: .incbin "actors/guard/walk_top5.raw"
spr_climb0: .incbin "actors/guard/climb_top1.raw"
spr_climb1: .incbin "actors/guard/climb_top2.raw"
spr_climb2: .incbin "actors/guard/climb_top3.raw"
spr_climb3: .incbin "actors/guard/climb_top4.raw"
spr_jump0: .incbin "actors/guard/jump_top1.raw"
spr_jump1: .incbin "actors/guard/jump_top2.raw"
spr_fire0: .incbin "actors/guard/fire_top1.raw"
spr_aim0: .incbin "actors/guard/aim_top1.raw"
spr_aim1: .incbin "actors/guard/aim_top2.raw"
spr_daim0: .incbin "actors/guard/daim_top1.raw"
spr_daim1: .incbin "actors/guard/daim_top2.raw"
spr_hit0: .incbin "actors/guard/hit_top1.raw"
spr_die0: .incbin "actors/guard/die_top.raw"
spr_throw0: .incbin "actors/guard/throw_top1.raw"
spr_throw1: .incbin "actors/guard/throw_top2.raw"
spr_throw2: .incbin "actors/guard/throw_top3.raw"
	

	.global guard_legs 
guard_legs:
	.byte 8,0		    @ nanims

	@ standing
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (25<<24) | (spr_legstand0 - .)
	
	@ walk
	.byte 8			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (4<<24) | (spr_legwalk0 - .)
	.word (4<<24) | (spr_legwalk1 - .)
	.word (4<<24) | (spr_legwalk2 - .)
	.word (4<<24) | (spr_legwalk3 - .)
	.word (4<<24) | (spr_legwalk4 - .)
	.word (4<<24) | (spr_legwalk5 - .)
	.word (4<<24) | (spr_legwalk6 - .)
	.word (4<<24) | (spr_legwalk7 - .)
	

	@ climb
	.byte 4			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (10<<24) | (spr_legclimb0 - .)
	.word (6<<24) | (spr_legclimb1 - .)
	.word (10<<24) | (spr_legclimb2 - .)
	.word (6<<24) | (spr_legclimb3 - .)

	@ jump
	.byte 2			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (36<<24) | (spr_legjump0 - .)
	.word (36<<24) | (spr_legjump1 - .)

	@ skid
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (30<<24) | (spr_legstand0 - .)

	@ duck
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (30<<24) | (spr_legduck0 - .)

	@ on ladder but not climbing (legs)
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_legclimb0 - .)

	.align

spr_legstand0: .incbin "actors/guard/stand_bottom1.raw"
spr_legwalk0: .incbin "actors/guard/walk_bottom1.raw"
spr_legwalk1: .incbin "actors/guard/walk_bottom2.raw"
spr_legwalk2: .incbin "actors/guard/walk_bottom3.raw"
spr_legwalk3: .incbin "actors/guard/walk_bottom4.raw"
spr_legwalk4: .incbin "actors/guard/walk_bottom5.raw"
spr_legwalk5: .incbin "actors/guard/walk_bottom6.raw"
spr_legwalk6: .incbin "actors/guard/walk_bottom7.raw"
spr_legwalk7: .incbin "actors/guard/walk_bottom8.raw"
spr_legclimb0: .incbin "actors/guard/climb_bottom1.raw"
spr_legclimb1: .incbin "actors/guard/climb_bottom2.raw"
spr_legclimb2: .incbin "actors/guard/climb_bottom3.raw"
spr_legclimb3: .incbin "actors/guard/climb_bottom4.raw"
spr_legjump0: .incbin "actors/guard/jump_bottom1.raw"
spr_legjump1: .incbin "actors/guard/jump_bottom2.raw"
spr_legduck0: .incbin "actors/guard/duck_bottom1.raw"

@ EOF guard.s
