

	.section .rodata
	.align

	.global rob_spr 
rob_spr:
	.byte 10,0		    @ nanims

	@ standing
	.byte 2          	    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (36<<24) | (spr_stand0 - .)
	.word (36<<24) | (spr_stand1 - .)

	
	@ walk (top)
	.byte 8			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_walk2 - .)
	.word (6<<24) | (spr_walk3 - .)
	.word (6<<24) | (spr_walk4 - .)
	.word (6<<24) | (spr_walk3 - .)
	.word (6<<24) | (spr_walk2 - .)
	.word (6<<24) | (spr_walk1 - .)
	.word (6<<24) | (spr_walk0 - .)
	.word (6<<24) | (spr_walk1 - .)

	@ jump (top)
	.byte 3			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (26<<24) | (spr_walk4 - .)
	.word (12<<24) | (spr_walk3 - .)
	.word (99<<24) | (spr_walk2 - .)
	
	@ aim forward
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_shoot0 - .)

	@ fire forward
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_shoot1 - .)

	@ aim up
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_shootup0 - .)

	@ fire up
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_shootup1 - .)



	@ hit (top)
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_hit - .)


	@ climb (top)
	.byte 4			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_climb0 - .)
	.word (6<<24) | (spr_climb1 - .)
	.word (6<<24) | (spr_climb2 - .)
	.word (6<<24) | (spr_climb3 - .)

	@ climb (top)
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_climb0 - .)


		
	.align
spr_stand0: .incbin "actors/rob/stand_top1.raw"
spr_stand1: .incbin "actors/rob/stand_top2.raw"
spr_walk0: .incbin "actors/rob/walk_top1.raw"
spr_walk1: .incbin "actors/rob/walk_top2.raw"
spr_walk2: .incbin "actors/rob/walk_top3.raw"
spr_walk3: .incbin "actors/rob/walk_top4.raw"
spr_walk4: .incbin "actors/rob/walk_top5.raw"
spr_shoot0: .incbin "actors/rob/fire_top1.raw"
spr_shoot1: .incbin "actors/rob/fire_top2.raw"
spr_shootup0: .incbin "actors/rob/aim_top1.raw"
spr_shootup1: .incbin "actors/rob/aim_top2.raw"
spr_hit: .incbin "actors/rob/hit_top1.raw"
spr_climb0: .incbin "actors/rob/climb_top1.raw"
spr_climb1: .incbin "actors/rob/climb_top2.raw"
spr_climb2: .incbin "actors/rob/climb_top3.raw"
spr_climb3: .incbin "actors/rob/climb_top4.raw"	


@ EOF rob.s
