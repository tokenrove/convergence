

	.section .rodata
	.align

	.global crow_spr 
crow_spr:
	.byte 4,0		    @ nanims

	@ standing
	.byte 6			    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (90<<24) | (spr_stand1 - .)
	.word (10<<24) | (spr_stand2 - .)
	.word (10<<24) | (spr_stand3 - .)
	.word (50<<24) | (spr_stand4 - .)
	.word (10<<24) | (spr_stand3 - .)
	.word (70<<24) | (spr_stand2 - .)
		

	@ eating
	.byte 17		    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (15<<24) | (spr_eat1 - .)
	.word (15<<24) | (spr_eat2 - .)
	.word (35<<24) | (spr_eat3 - .)
	.word (6<<24) | (spr_eat4 - .)
	.word (25<<24) | (spr_eat3 - .)
	.word (4<<24) | (spr_eat4 - .)
	.word (35<<24) | (spr_eat3 - .)
	.word (6<<24) | (spr_eat4 - .)
	.word (35<<24) | (spr_eat3 - .)
	.word (15<<24) | (spr_eat2 - .)
	.word (15<<24) | (spr_eat1 - .)
	.word (90<<24) | (spr_stand1 - .)
	.word (10<<24) | (spr_stand2 - .)
	.word (10<<24) | (spr_stand3 - .)
	.word (50<<24) | (spr_stand4 - .)
	.word (10<<24) | (spr_stand3 - .)
	.word (70<<24) | (spr_stand2 - .)
		
	@ flying
	.byte 4 		    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (8<<24) | (spr_fly1 - .)
	.word (8<<24) | (spr_fly2 - .)
	.word (8<<24) | (spr_fly3 - .)
	.word (8<<24) | (spr_fly4 - .)


	@ dying
	.byte 1 		    @ nframes
	.byte 0b00010000	    @ size<<4 | palette

	.word (90<<24) | (spr_die1 - .)
	.align
	
spr_stand1: .incbin "actors/crow/stand1.raw"
spr_stand2: .incbin "actors/crow/stand2.raw"
spr_stand3: .incbin "actors/crow/stand3.raw"
spr_stand4: .incbin "actors/crow/stand4.raw"
spr_eat1: .incbin "actors/crow/eat1.raw"
spr_eat2: .incbin "actors/crow/eat2.raw"
spr_eat3: .incbin "actors/crow/eat3.raw"
spr_eat4: .incbin "actors/crow/eat4.raw"
spr_fly1: .incbin "actors/crow/fly1.raw"
spr_fly2: .incbin "actors/crow/fly2.raw"
spr_fly3: .incbin "actors/crow/fly3.raw"
spr_fly4: .incbin "actors/crow/fly4.raw"
spr_die1: .incbin "actors/crow/die1.raw"
	
@ EOF crow.s
