

	.section .rodata
	.align

	.global body_spr 
body_spr:
	.byte 1,0		    @ nanims

	@ body
	.byte 1			    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (90<<24) | (spr_body - .)
			
	
	.align
spr_body: .incbin "actors/stomper/body.raw"



	.global pivot_spr 
pivot_spr:
	.byte 1,0		    @ nanims

	@ pivot
	.byte 1			    @ nframes
	.byte 0b00100000	    @ size<<4 | palette

	.word (90<<24) | (spr_pivot - .)
			
	
	.align
spr_pivot: .incbin "actors/stomper/pivot.raw"


	.global barrels_spr 
barrels_spr:
	.byte 1,0		    @ nanims

	@ barrels
	.byte 1			    @ nframes
	.byte 0b01110000	    @ size<<4 | palette

	.word (90<<24) | (spr_barrels - .)
			
	
	.align
spr_barrels: .incbin "actors/stomper/barrels.raw"


	.global foot_spr 
foot_spr:
	.byte 1,0		    @ nanims

	@ foot
	.byte 1			    @ nframes
	.byte 0b00110000	    @ size<<4 | palette

	.word (90<<24) | (spr_foot - .)
			
	
	.align
spr_foot: .incbin "actors/stomper/foot.raw"



@ EOF stomper.s
