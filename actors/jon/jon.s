

	.section .rodata
	.align

	.global jon_spr 
jon_spr:
	.byte 11,0		    @ nanims

	@ standing
	.byte 1          	    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (36<<24) | (spr_stand0 - .)

	
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

	.word (6<<24) | (spr_stand0 - .)

	@ fire forward
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_shoot0 - .)

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


	@ climb (top)
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (80<<24) | (spr_die0 - .)


		
	.align
spr_stand0: .incbin "actors/jon/stand_top1.raw"
spr_walk0: .incbin "actors/jon/walk_top1.raw"
spr_walk1: .incbin "actors/jon/walk_top2.raw"
spr_walk2: .incbin "actors/jon/walk_top3.raw"
spr_walk3: .incbin "actors/jon/walk_top4.raw"
spr_walk4: .incbin "actors/jon/walk_top5.raw"
spr_shoot0: .incbin "actors/jon/fire_top1.raw"
spr_shootup0: .incbin "actors/jon/aim_top1.raw"
spr_shootup1: .incbin "actors/jon/aim_top2.raw"
spr_hit: .incbin "actors/jon/hit_top1.raw"
spr_climb0: .incbin "actors/jon/climb_top1.raw"
spr_climb1: .incbin "actors/jon/climb_top2.raw"
spr_climb2: .incbin "actors/jon/climb_top3.raw"
spr_climb3: .incbin "actors/jon/climb_top4.raw"	
spr_die0: .incbin "actors/jon/die_top.raw"	


@ EOF jon.s
