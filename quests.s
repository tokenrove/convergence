@ quests -- character-specific quest data.
@ Convergence
@ Copyright Pureplay Games / 2002
@
@ $Id: quests.s,v 1.56 2002/12/12 19:38:21 tek Exp $

	.section .rodata
	.align

@ The quest table is a NULL-terminated list of pointers.
@ Each quest table entry is a pointer to the following structure:
@
@ <word-aligned ASCIIZ string -- name of quest>
@ 0	byte	nlevels
@ 1	3byte	unused
@ 4	word	function to call on starting the game
@ 8	word	function to call on beating the game
@ nlevels*word	ptr to level (or area) n
@
@ Each level has the form:
@ {
@ <word-aligned ASCIIZ string -- name of level>
@ +0	word	ptr to level
@ +4	hero's actor const for this level (see level.s)
@ ?? 	byte	music idx
@ +1	byte	trigger counter initial value
@ +2	byte	ntriggers
@ +3	byte	n supplementary actors
@ balance disturbance rates: (value*2 = frames/instability)
@ +4	byte	unused
@ +5	byte	instability on easy
@ +6	byte	instability on normal
@ +7	byte	instability on hard
@   triggers {
@ +0	byte	xenh cccc
@		x = unused
@		e = easy
@		n = normal
@		h = hard
@		c = cause:
@		    0 = rectangle
@		    1 = actor alive
@		    2 = set of actors alive
@ +1	byte	effect
@		1 = death
@		2 = next area
@		3 = next level
@		4 = previous area
@		slush, wind here
@ +2	byte	parameter for effect
@ +3	byte	candidates
@		for rectangle:
@		cxxx xxah
@               c = dependent on counter (unlocked when counter = 0)
@		a = any actor
@		h = hero
@		for actorlive:
@		xxxx iiii
@		i = trigactor id
@ if cause is a rectangle:
@ +4	hword	x1
@ +6	hword	x2
@ +8	hword	y1
@ +10	hword	y2
@ if cause is an actor's death:
@ +4	8pad
@   }
@   actors {
@	same format as specified in level.s
@   }
@ }
@

	.include "game.inc"


	.global quests_table
quests_table:
	.word sam_quest, alpha_guard_quest, beta_guard_quest, sam_fitness_quest, 0

	@ Sam (male)
sam_quest:
	.string "Sam's Ordeal"
	.align
	.byte 23, 0, 0, 0
	.word 0, 0

	.word sam_medical, sam_courtyard, sam_vehicle, sam_roof1
	.word sam_roof2, sam_sanitation, sam_sewers, sam_pipemaze
	.word sam_ice_sewers, sam_cold_storage, sam_cryolab
	.word sam_cryo_bossfight, sam_genetics, sam_zoo, sam_office, sam_quantum_lab
	.word sam_quantum_bossfight, sam_grid, sam_grid_bossfight
	.word sam_skywalk, sam_minos_fight, sam_apparatus_shaft
	.word sam_final_stage

	@ level 1
sam_medical:
        .string "Medical"
        .align
	.word level_medical

	@ Sam the hero
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 1200,170		    @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align

	.byte 0, 0, 1, 0
	.byte 0, 150, 120, 90

	@ trigger: hit end of area, go to next
	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTAREA,0
	.byte TR_HERO
	.hword 1944, 2010, 844, 895

	@
sam_courtyard:
        .string "Courtyard"
        .align
	.word level_courtyard

	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 50,100               @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align

	.byte 1, 0, 1, 0
	.byte 0, 150, 120, 90

	@ trigger: hit end of level, go to next
	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTLEVEL,0
	.byte TR_HERO
	.hword 1463, 1500, 133, 167

	@ level 2
sam_vehicle:
        .string "Vehicle Yard"
        .align
	.word level_vehicle
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 16, 224              @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,1,0
	.byte 0, 150, 120, 90

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTAREA,0
	.byte TR_HERO
	.hword 3996, 4100, 191, 270

sam_roof1:
        .string "Rooftop 1"
        .align
	.word level_roof1
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 16,236                @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,1,0
	.byte 0, 120, 100, 80

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTAREA,0
	.byte TR_HERO
	.hword 1937, 2000, 137, 180

sam_roof2:
        .string "Rooftop 2"
        .align
	.word level_roof2
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 49,35                  @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,1,0
	.byte 0, 120, 100, 80

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTLEVEL,0
	.byte TR_HERO
	.hword 2711, 2791, 172, 231

	@ level 3
sam_sanitation:
        .string "Sanitation Building"
        .align
	.word level_sanitation
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 16,136                @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,1,0
	.byte 0, 110, 90, 70

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTLEVEL,0
	.byte TR_HERO
	.hword 3993, 4008, 938, 1262

	@ level 4
sam_sewers:
        .string "Sewers"
        .align
	.word level_sewers
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 168,72                  @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,1,0
	.byte 0, 110, 90, 70

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTAREA,0
	.byte TR_HERO
	.hword 1902, 2030, 178, 231

sam_pipemaze:
        .string "Pipe Maze"
        .align
	.word level_pipes
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 140,120                @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,1,0
	.byte 0, 110, 90, 70

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTAREA,0
	.byte TR_HERO
	.hword 104, 176, 0, 72

sam_ice_sewers:
        .string "Ice Sewers"
        .align
	.word level_icesewers
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 880,1448                  @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,1,0
	.byte 0, 100, 80, 60

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTLEVEL,0
	.byte TR_HERO
	.hword 18, 71, 370, 416

	@ level 5
sam_cold_storage:
        .string "Cold Storage"
        .align
	.word level_cold_storage
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 1160, 1408           @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,1,0
	.byte 0, 90, 75, 55

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTAREA,0
	.byte TR_HERO
	.hword 1515, 1600, 338, 370

sam_cryolab:
        .string "Cryo Lab"
        .align
	.word level_cryolab
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 64, 552              @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,1,0
	.byte 0, 90, 73, 52

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTAREA,0
	.byte TR_HERO
	.hword 2648, 2688, 168, 208

sam_cryo_bossfight:
        .string "Cryo Bossfight"
        .align
	.word level_c_boss
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 440, 160             @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,1,0
	.byte 0, 90, 70, 50

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTLEVEL,0
	.byte TR_HERO
	.hword 15, 63, 168, 208

	@ level 6
sam_genetics:
        .string "Genetics Lab"
        .align
	.word level_genetics
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 504, 72              @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,80,1,0
	.byte 0, 80, 60, 40

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTAREA,0
	.byte TR_HERO
	.hword 2984, 3008, 120, 152

sam_zoo:
        .string "Zoo"
        .align
	.word level_zoo
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 32, 632              @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,80,0,0
	.byte 0, 80, 55, 35

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTLEVEL,0
	.byte TR_HERO
	.hword 0, 80, 936, 1040

	@ level 7
sam_office:
        .string "Offices"
        .align
	.word level_office
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 3808, 960            @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,0,0
	.byte 0, 60, 50, 33

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTLEVEL,0
	.byte TR_HERO
	.hword 1, 84, 318, 391

	@ level 8
sam_quantum_lab:
        .string "Quantum Lab"
        .align
	.word level_quantum
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 2008, 496              @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,40,1,0
	.byte 0, 40, 30, 25

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTAREA,0
	.byte TR_HERO
	.hword 1, 74, 130, 147

sam_quantum_bossfight:
        .string "Quantum Bossfight"
        .align
	.word level_jd_boss
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 424, 192              @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,1,0
	.byte 0, 30, 20, 15

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTAREA,0
	.byte TR_HERO
	.hword 0, 74, 154, 240

sam_grid:
        .string "Grid"
        .align
	.word level_grid
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 2888, 1088           @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,1,0
	.byte 0, 35, 25, 15

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTAREA,0
	.byte TR_HERO
	.hword 2888, 2954, 384, 430

sam_grid_bossfight:
        .string "Grid Bossfight"
        .align
	.word level_s_boss
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 104, 200             @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,1,0
	.byte 0, 20, 15, 10

	.byte TR_ACTORLIVE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTLEVEL,0
	.byte 1			    @ trigger actor
	.hword 0, 0, 0, 0

	@ level 9
sam_skywalk:
        .string "Skywalk"
        .align
	.word level_skywalk
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 32, 256              @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,20,1,0
	.byte 0, 20, 15, 10

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTLEVEL,0
	.byte TR_HERO
	.hword 5028, 5087, 295, 343

	@ level 10
sam_minos_fight:
        .string "Minos Fight"
        .align
	.word level_m_boss
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 584, 424            @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,1,0
	.byte 0, 15, 12, 8

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTAREA,0
	.byte TR_HERO
	.hword 0, 72, 421, 470

sam_apparatus_shaft:
        .string "Apparatus Shaft"
        .align
	.word level_shaft
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 8, 1832              @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,1,0
	.byte 0, 10, 8, 7

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTAREA,0
	.byte TR_HERO
	.hword 240, 302, 169, 231

sam_final_stage:
        .string "Apparatus"
        .align
	.word level_final
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 400, 1000
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 0,0,1,0
	.byte 0,8,7,5

	.byte TR_ACTORLIVE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTLEVEL,0
	.byte 1			    @ trigger actor
	.hword 0, 0, 0, 0



	@ Billy's quest
alpha_guard_quest:
	.string "The Escape"
	.align
	.byte 1, 0, 0, 0
	.word 0, 0
	.word 0f
	@ level 1
0:	.string "Offices"
        .align
        .word level_office
	.hword ARCH_BILLY
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 816, 390
	.byte 5			    @ state size
	.byte 0, 0, 0, 0, 0
	.align
	.byte 0,0,0,0
	.byte 0,30,30,30


	@ Quinn's quest
beta_guard_quest:
	.string "Code Red"
	.align
	.byte 3, 0, 0, 0
	.word 0, 0
	.word quinn_medical, quinn_courtyard, quinn_vehicle_yard

	@ level 1
quinn_medical:
        .string "Medical Building"
        .align
        .word level_medical
	.hword ARCH_QUINN
	.byte 0, 0b00100111	    @ beta, enh
	.hword 48, 872
	.byte 5			    @ state size
	.byte 0, 0, 0, 0, 0x5a
	.align
	.byte 0,2,1,2
	.byte 0,30,30,30

	@ trigger: hit end of area, go to next
	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTAREA,0
	.byte TR_HERO|TR_COUNTER_DEPENDENT
	.hword 1944, 2010, 844, 895

        .hword ARCH_SITTING_HOSTAGE
        .byte 0, 0b00100111
        .hword 104, 1136
        .byte 0
        .align

        .hword ARCH_LEANING_HOSTAGE
        .byte 0, 0b00100111
        .hword 1192, 304
        .byte 0
        .align


quinn_courtyard:
        .string "Courtyard"
        .align
	.word level_courtyard

	.hword ARCH_QUINN
	.byte 0, 0b00100111
	.hword 48,144
	.byte 5
	.byte 0, 0, 0, 0, 0x5a
	.align

	.byte 0, 0, 1, 0
	.byte 0, 150, 120, 90

	@ trigger: hit end of level, go to next
	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTAREA,0
	.byte TR_HERO
	.hword 1463, 1500, 133, 176

quinn_vehicle_yard:
        .string "Vehicle Yard"
        .align
	.word level_vehicle
	.hword ARCH_QUINN
	.byte 0, 0b00100111
	.hword 48, 232
	.byte 5
	.byte 0, 0, 0, 0, 0x5a
	.align
	.byte 0,2,1,2
	.byte 0, 150, 120, 90

	.byte TR_RECTANGLE|TR_EASY|TR_NORMAL|TR_HARD
	.byte TR_NEXTLEVEL,0
	.byte TR_HERO|TR_COUNTER_DEPENDENT
	.hword 4048, 4088, 176, 264

        .hword ARCH_PANTING_HOSTAGE
        .byte 0, 0b00100111
        .hword 1704, 208
        .byte 0
        .align

        .hword ARCH_SITTING_HOSTAGE
        .byte 0, 0b00100111
        .hword 2696, 248
        .byte 0
        .align


	@ Gym quest!
sam_fitness_quest:
	.string "Sam's gym"
	.align
	.byte 1, 0, 0, 0
	.word 0, 0
	.word 0f
	@ level 1
0:	.string "Gym"
        .align
        .word level_gym
	.hword ARCH_SAM
	.byte 0, 0b00010111	    @ alpha, enh
	.hword 1176,1176	    @ (x,y)
	.byte 6			    @ state size
	.byte 0, 0, 0, 0, 0, 0
	.align
	.byte 2,0,0,0
	.byte 0,30,30,30


@ EOF quests.s
