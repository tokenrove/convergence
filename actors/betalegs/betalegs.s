	.global beta_legs 
beta_legs:
	.byte 8,0		    @ nanims

	@ standing
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_legstand0 - .)


	@ walk (top)
	.byte 8			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_legwalk0 - .)
	.word (6<<24) | (spr_legwalk1 - .)
	.word (6<<24) | (spr_legwalk2 - .)
	.word (6<<24) | (spr_legwalk3 - .)
	.word (6<<24) | (spr_legwalk4 - .)
	.word (6<<24) | (spr_legwalk5 - .)
	.word (6<<24) | (spr_legwalk6 - .)
	.word (6<<24) | (spr_legwalk7 - .)


	@ jump
	.byte 3			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (26<<24) | (spr_legwalk5 - .)
	.word (12<<24) | (spr_legwalk4 - .)
	.word (99<<24) | (spr_legwalk3 - .)

	@ climb (top)
	.byte 4			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_legclimb0 - .)
	.word (6<<24) | (spr_legclimb1 - .)
	.word (6<<24) | (spr_legclimb2 - .)
	.word (6<<24) | (spr_legclimb3 - .)


	@ ducking
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_legduck0 - .)


	@ climb (top)
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_legclimb0 - .)

	
	@ skid (regurgitate)
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_skid - .)


	@ blank frame (spritely dance)
	.byte 1			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (6<<24) | (spr_blank - .)


	.align

spr_legstand0: .incbin "actors/betalegs/stand_bottom1.raw"
spr_legwalk0: .incbin "actors/betalegs/walk_bottom1.raw"
spr_legwalk1: .incbin "actors/betalegs/walk_bottom2.raw"
spr_legwalk2: .incbin "actors/betalegs/walk_bottom3.raw"
spr_legwalk3: .incbin "actors/betalegs/walk_bottom4.raw"
spr_legwalk4: .incbin "actors/betalegs/walk_bottom5.raw"
spr_legwalk5: .incbin "actors/betalegs/walk_bottom6.raw"
spr_legwalk6: .incbin "actors/betalegs/walk_bottom7.raw"
spr_legwalk7: .incbin "actors/betalegs/walk_bottom8.raw"
spr_legclimb0: .incbin "actors/betalegs/climb_bottom1.raw"
spr_legclimb1: .incbin "actors/betalegs/climb_bottom2.raw"
spr_legclimb2: .incbin "actors/betalegs/climb_bottom3.raw"
spr_legclimb3: .incbin "actors/betalegs/climb_bottom4.raw"	
spr_legduck0: .incbin "actors/betalegs/duck_bottom1.raw"	
spr_skid: .incbin "actors/betalegs/skid.raw"	
spr_blank: .incbin "actors/betalegs/blank.raw"	
