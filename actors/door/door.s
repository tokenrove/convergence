

	.section .rodata
	.align

	.global door_spr 
door_spr:
	.byte 4,0		    @ nanims

	@ closed
	.byte 1			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (90<<24) | (spr_door1 - .)

	
	@ opening
	.byte 8			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (6<<24) | (spr_door1 - .)
	.word (6<<24) | (spr_door2 - .)
	.word (6<<24) | (spr_door3 - .)
	.word (6<<24) | (spr_door4 - .)
	.word (6<<24) | (spr_door5 - .)
	.word (6<<24) | (spr_door6 - .)
	.word (6<<24) | (spr_door7 - .)
	.word (6<<24) | (spr_door8 - .)


	@ open
	.byte 1			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (90<<24) | (spr_door8 - .)


	@ opening
	.byte 4			    @ nframes
	.byte 0b10100000	    @ size<<4 | palette

	.word (6<<24) | (spr_door8 - .)
	.word (6<<24) | (spr_door7 - .)
	.word (6<<24) | (spr_door6 - .)
	.word (6<<24) | (spr_door5 - .)
	.word (6<<24) | (spr_door4 - .)
	.word (6<<24) | (spr_door3 - .)
	.word (6<<24) | (spr_door2 - .)
	.word (6<<24) | (spr_door1 - .)

	.align
	
spr_door1: .incbin "actors/door/door1.raw"
spr_door2: .incbin "actors/door/door2.raw"
spr_door3: .incbin "actors/door/door3.raw"
spr_door4: .incbin "actors/door/door4.raw"
spr_door5: .incbin "actors/door/door5.raw"
spr_door6: .incbin "actors/door/door6.raw"
spr_door7: .incbin "actors/door/door7.raw"
spr_door8: .incbin "actors/door/door8.raw"


@ EOF door.s
