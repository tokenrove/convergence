

	.section .rodata
	.align

	.global crawler_spr 
crawler_spr:
	.byte 5,0		    @ nanims

	@ walking
	.byte 8 		    @ nframes
	.byte 0b01110000	    @ size<<4 | palette
	.word (8<<24) | (spr_walk1 - .)
	.word (8<<24) | (spr_walk2 - .)
	.word (8<<24) | (spr_walk3 - .)
	.word (8<<24) | (spr_walk4 - .)
	.word (8<<24) | (spr_walk5 - .)
	.word (8<<24) | (spr_walk6 - .)
	.word (8<<24) | (spr_walk7 - .)
	.word (8<<24) | (spr_walk8 - .)


	@ retreating
	.byte 8 		    @ nframes
	.byte 0b01110000	    @ size<<4 | palette
	.word (8<<24) | (spr_walk8 - .)
	.word (8<<24) | (spr_walk7 - .)
	.word (8<<24) | (spr_walk6 - .)
	.word (8<<24) | (spr_walk5 - .)
	.word (8<<24) | (spr_walk4 - .)
	.word (8<<24) | (spr_walk3 - .)
	.word (8<<24) | (spr_walk2 - .)
	.word (8<<24) | (spr_walk1 - .)


	@ standing
	.byte 1 		    @ nframes
	.byte 0b01110000	    @ size<<4 | palette

	.word (90<<24) | (spr_stand1 - .)

			
	@ killing
	.byte 3 		    @ nframes
	.byte 0b01110000	    @ size<<4 | palette

	.word (4<<24) | (spr_attack1 - .)
	.word (8<<24) | (spr_attack2 - .)
	.word (8<<24) | (spr_attack3 - .)
	

	@ hit
	.byte 1 		    @ nframes
	.byte 0b01110000	    @ size<<4 | palette

	.word (8<<24) | (spr_hit1 - .)


	@ dying
	.byte 1 		    @ nframes
	.byte 0b01110000	    @ size<<4 | palette

	.word (90<<24) | (spr_die1 - .)

		
	.align
	
spr_walk1: .incbin "actors/crawler/walk1.raw"
spr_walk2: .incbin "actors/crawler/walk2.raw"
spr_walk3: .incbin "actors/crawler/walk3.raw"
spr_walk4: .incbin "actors/crawler/walk4.raw"
spr_walk5: .incbin "actors/crawler/walk5.raw"
spr_walk6: .incbin "actors/crawler/walk6.raw"
spr_walk7: .incbin "actors/crawler/walk7.raw"
spr_walk8: .incbin "actors/crawler/walk8.raw"
spr_attack1: .incbin "actors/crawler/attack1.raw"
spr_attack2: .incbin "actors/crawler/attack2.raw"
spr_attack3: .incbin "actors/crawler/attack3.raw"
spr_hit1: .incbin "actors/crawler/hit1.raw"
spr_stand1: .incbin "actors/crawler/walk1.raw"
spr_die1: .incbin "actors/crawler/die.raw"
	
@ EOF crawler.s
