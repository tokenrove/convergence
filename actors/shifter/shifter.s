

	.section .rodata
	.align

	.global shifter_spr
shifter_spr:
	.byte 2,0		    @ nanims

	@ Intact
	.byte 1			    @ nframes
	.byte 0b00110000		    @ size<<4 | palette

	.word (90<<24) | (spr_intact0 - .)

	@ Damaged
	.byte 1			    @ nframes
	.byte 0b00110000		    @ size<<4 | palette

	.word (90<<24) | (spr_damage0 - .)

	.align

spr_intact0: .incbin "actors/shifter/biftek1.raw"
spr_damage0: .incbin "actors/shifter/biftek2.raw"



