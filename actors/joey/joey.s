

	.section .rodata
	.align

	.global joey_spr 
joey_spr:
	.byte 11,0		    @ nanims

	@ standing
	.byte 4			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (36<<24) | (spr_stand0 - .)
	.word (10<<24) | (spr_stand1 - .)
	.word (30<<24) | (spr_stand2 - .)
	.word (10<<24) | (spr_stand1 - .)

	
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


	@ die (top)
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (90<<24) | (spr_die0 - .)

		
		
	.align
spr_stand0: .incbin "actors/joey/stand_top1.raw"
spr_stand1: .incbin "actors/joey/stand_top2.raw"
spr_stand2: .incbin "actors/joey/stand_top3.raw"
spr_walk0: .incbin "actors/joey/walk_top1.raw"
spr_walk1: .incbin "actors/joey/walk_top2.raw"
spr_walk2: .incbin "actors/joey/walk_top3.raw"
spr_walk3: .incbin "actors/joey/walk_top4.raw"
spr_walk4: .incbin "actors/joey/walk_top5.raw"
spr_shoot0: .incbin "actors/joey/fire_top1.raw"
spr_shoot1: .incbin "actors/joey/fire_top2.raw"
spr_shootup0: .incbin "actors/joey/aim_top1.raw"
spr_shootup1: .incbin "actors/joey/aim_top2.raw"
spr_hit: .incbin "actors/joey/hit_top1.raw"
spr_climb0: .incbin "actors/joey/climb_top1.raw"
spr_climb1: .incbin "actors/joey/climb_top2.raw"
spr_climb2: .incbin "actors/joey/climb_top3.raw"
spr_climb3: .incbin "actors/joey/climb_top4.raw"	
spr_die0: .incbin "actors/joey/die_top.raw"	


@ EOF joey.s
