

	.section .rodata
	.align

	.global sam_spr 
sam_spr:
	.byte 14,0		    @ nanims

	@ standing
	.byte 2			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (25<<24) | (spr_stand0 - .)
	.word (25<<24) | (spr_stand1 - .)

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

	@ jump up
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (32<<24) | (spr_jump0 - .)
	
	@ Hit from front
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (30<<24) | (spr_hit0 - .)

	@ Hit from back
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (30<<24) | (spr_hit1 - .)

	@ look
	.byte 3			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_look0 - .)
	.word (30<<24) | (spr_look1 - .)
	.word (6<<24) | (spr_look0 - .)

	@ bounce
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (30<<24) | (spr_bounce0 - .)

	@ skid
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (30<<24) | (spr_skid0 - .)

	@ duck
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (30<<24) | (spr_duck0 - .)

	@ on ladder but not climbing (top)
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (30<<24) | (spr_climb2 - .)

	@ rightstrike
	.byte 6			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (3<<24) | (spr_rightstrike0 - .)
	.word (3<<24) | (spr_rightstrike1 - .)
	.word (3<<24) | (spr_rightstrike2 - .)
	.word (3<<24) | (spr_rightstrike3 - .)
	.word (3<<24) | (spr_rightstrike4 - .)
	.word (3<<24) | (spr_rightstrike5 - .)

	@ leftstrike
	.byte 6			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (3<<24) | (spr_leftstrike0 - .)
	.word (3<<24) | (spr_leftstrike1 - .)
	.word (3<<24) | (spr_leftstrike2 - .)
	.word (3<<24) | (spr_leftstrike3 - .)
	.word (3<<24) | (spr_leftstrike4 - .)
	.word (3<<24) | (spr_leftstrike5 - .)

	@ jump down
	.byte 2			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (10<<24) | (spr_jump1 - .)
	.word (90<<24) | (spr_jump1 - .)
	.align

spr_stand0: .incbin "actors/sam/stand_top1.raw"
spr_stand1: .incbin "actors/sam/stand_top2.raw"
spr_look0: .incbin "actors/sam/look_top1.raw"
spr_look1: .incbin "actors/sam/look_top2.raw"
spr_walk0: .incbin "actors/sam/walk_top1.raw"
spr_walk1: .incbin "actors/sam/walk_top2.raw"
spr_walk2: .incbin "actors/sam/walk_top3.raw"
spr_walk3: .incbin "actors/sam/walk_top4.raw"
spr_walk4: .incbin "actors/sam/walk_top5.raw"

spr_climb0: .incbin "actors/sam/climb_top1.raw"
spr_climb1: .incbin "actors/sam/climb_top2.raw"
spr_climb2: .incbin "actors/sam/climb_top3.raw"
spr_climb3: .incbin "actors/sam/climb_top4.raw"
spr_jump0: .incbin "actors/sam/jump_top1.raw"
spr_jump1: .incbin "actors/sam/jump_top2.raw"
spr_jump2: .incbin "actors/sam/jump_top3.raw"
spr_hit0: .incbin "actors/sam/hit_top1.raw"
spr_hit1: .incbin "actors/sam/hit_top2.raw"	
spr_bounce0: .incbin "actors/sam/bounce_top.raw"
spr_skid0: .incbin "actors/sam/skid_top1.raw"
spr_duck0: .incbin "actors/sam/duck_top1.raw"
spr_rightstrike0: .incbin "actors/sam/jump_top1.raw"
spr_rightstrike1: .incbin "actors/sam/rightstrike_top2.raw"
spr_rightstrike2: .incbin "actors/sam/rightstrike_top3.raw"
spr_rightstrike3: .incbin "actors/sam/rightstrike_top4.raw"
spr_rightstrike4: .incbin "actors/sam/rightstrike_top5.raw"
spr_rightstrike5: .incbin "actors/sam/rightstrike_top6.raw"
spr_leftstrike0: .incbin "actors/sam/leftstrike_top1.raw"
spr_leftstrike1: .incbin "actors/sam/leftstrike_top2.raw"
spr_leftstrike2: .incbin "actors/sam/leftstrike_top3.raw"
spr_leftstrike3: .incbin "actors/sam/leftstrike_top4.raw"
spr_leftstrike4: .incbin "actors/sam/leftstrike_top5.raw"
spr_leftstrike5: .incbin "actors/sam/leftstrike_top6.raw"


	
	.global samlegs_spr 
samlegs_spr:
	.byte 7,0		    @ nanims

	@ standing
	.byte 2			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (25<<24) | (spr_legstand0 - .)
	.word (25<<24) | (spr_legstand1 - .)
	
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
	.byte 3			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_legjump0 - .)
	.word (36<<24) | (spr_legjump1 - .)
	.word (99<<24) | (spr_legjump0 - .)

	@ bounce
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (30<<24) | (spr_legbounce0 - .)

	@ skid
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (30<<24) | (spr_legskid0 - .)

	@ duck
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (30<<24) | (spr_legduck0 - .)

	@ on ladder but not climbing (legs)
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_legclimb0 - .)

	.align

spr_legstand0: .incbin "actors/sam/stand_bottom.raw"
spr_legstand1: .incbin "actors/sam/stand_bottom2.raw"
spr_legwalk0: .incbin "actors/sam/walk_bottom1.raw"
spr_legwalk1: .incbin "actors/sam/walk_bottom2.raw"
spr_legwalk2: .incbin "actors/sam/walk_bottom3.raw"
spr_legwalk3: .incbin "actors/sam/walk_bottom4.raw"
spr_legwalk4: .incbin "actors/sam/walk_bottom5.raw"
spr_legwalk5: .incbin "actors/sam/walk_bottom6.raw"
spr_legwalk6: .incbin "actors/sam/walk_bottom7.raw"
spr_legwalk7: .incbin "actors/sam/walk_bottom8.raw"
spr_legclimb0: .incbin "actors/sam/climb_bottom1.raw"
spr_legclimb1: .incbin "actors/sam/climb_bottom2.raw"
spr_legclimb2: .incbin "actors/sam/climb_bottom3.raw"
spr_legclimb3: .incbin "actors/sam/climb_bottom4.raw"
spr_legjump0: .incbin "actors/sam/jump_bottom1.raw"
spr_legjump1: .incbin "actors/sam/jump_bottom2.raw"
spr_legbounce0: .incbin "actors/sam/bounce_bottom.raw"
spr_legduck0: .incbin "actors/sam/duck_bottom1.raw"
spr_legskid0: .incbin "actors/sam/skid_bottom1.raw"

@ EOF sam.s
