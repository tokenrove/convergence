

	.section .rodata
	.align

	.global quinn_spr 
quinn_spr:
	.byte 16,0		    @ nanims

	@ standing
	.byte 1			    @ nframes
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
	

	@ fire forward
	.byte 2			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_shoot1 - .)
	.word (90<<24) | (spr_shoot0 - .)

	@ aim up
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (90<<24) | (spr_shootup0 - .)

	@ fire up
	.byte 2			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_shootup1 - .)
	.word (90<<24) | (spr_shootup0 - .)



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


	@ throw (top)
	.byte 3			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_throw0 - .)
	.word (6<<24) | (spr_throw1 - .)
	.word (6<<24) | (spr_throw2 - .)


	@ slide (top)
	.byte 1			    @ nframes
	.byte 0b01100000	    @ size<<4 | palette

	.word (90<<24) | (spr_slide0 - .)

	@ skid (top)
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (90<<24) | (spr_walk1 - .)


	@ reload
	.byte 12		    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (8<<24) | (spr_reload0 - .)
	.word (8<<24) | (spr_reload1 - .)
	.word (8<<24) | (spr_reload0 - .)
	.word (8<<24) | (spr_reload2 - .)
	.word (8<<24) | (spr_reload3 - .)
	.word (4<<24) | (spr_reload4 - .)
	.word (8<<24) | (spr_reload3 - .)
	.word (8<<24) | (spr_reload5 - .)
	.word (8<<24) | (spr_reload6 - .)
	.word (4<<24) | (spr_reload7 - .)
	.word (8<<24) | (spr_reload6 - .)
	.word (8<<24) | (spr_reload8 - .)


	@ aim down
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (90<<24) | (spr_shootdown0 - .)

	@ fire down
	.byte 2			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_shootdown1 - .)
	.word (90<<24) | (spr_shootdown0 - .)

		

	.align
spr_stand0: .incbin "actors/quinn/stand_top1.raw"
spr_stand1: .incbin "actors/quinn/stand_top2.raw"
spr_walk0: .incbin "actors/quinn/walk_top1.raw"
spr_walk1: .incbin "actors/quinn/walk_top2.raw"
spr_walk2: .incbin "actors/quinn/walk_top3.raw"
spr_walk3: .incbin "actors/quinn/walk_top4.raw"
spr_walk4: .incbin "actors/quinn/walk_top5.raw"
spr_shoot0: .incbin "actors/quinn/fire_top1.raw"
spr_shoot1: .incbin "actors/quinn/fire_top2.raw"
spr_shootup0: .incbin "actors/quinn/aim_top1.raw"
spr_shootup1: .incbin "actors/quinn/aim_top2.raw"
spr_hit: .incbin "actors/quinn/hit_top1.raw"
spr_climb0: .incbin "actors/quinn/climb_top1.raw"
spr_climb1: .incbin "actors/quinn/climb_top2.raw"
spr_climb2: .incbin "actors/quinn/climb_top3.raw"
spr_climb3: .incbin "actors/quinn/climb_top4.raw"	
spr_throw0: .incbin "actors/quinn/throw_top1.raw"
spr_throw1: .incbin "actors/quinn/throw_top2.raw"
spr_throw2: .incbin "actors/quinn/throw_top3.raw"
spr_slide0: .incbin "actors/quinn/slide.raw"
spr_reload0: .incbin "actors/quinn/reload_top1.raw"
spr_reload1: .incbin "actors/quinn/reload_top2.raw"
spr_reload2: .incbin "actors/quinn/reload_top3.raw"
spr_reload3: .incbin "actors/quinn/reload_top4.raw"
spr_reload4: .incbin "actors/quinn/reload_top5.raw"
spr_reload5: .incbin "actors/quinn/reload_top6.raw"
spr_reload6: .incbin "actors/quinn/reload_top7.raw"
spr_reload7: .incbin "actors/quinn/reload_top8.raw"
spr_reload8: .incbin "actors/quinn/reload_top9.raw"
spr_shootdown0: .incbin "actors/quinn/daim_top1.raw"
spr_shootdown1: .incbin "actors/quinn/daim_top2.raw"



@ EOF quinn.s
