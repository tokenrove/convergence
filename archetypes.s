@ archetypes
@ Convergence
@ Copyright Pureplay Games / 2002
@
@ $Id: archetypes.s,v 1.77 2002/12/13 18:36:02 retsyn Exp $

@ Archetype format:
@ 0	byte	mass
@ 1	byte	speed on easy
@	byte	... on normal
@	byte	... on hard
@ 4	byte	health/balance on easy
@	byte	... on normal
@	byte	... on hard
@ 7	byte	number of parts
@ 8	nparts*
@ {
@ +0	word	ptr to sprite const
@ +4	byte	cppp pppp
@		c = collidable?
@		p = palette for this part
@ +5	byte	[FIRST PART ONLY]
@		mxxx xxxn
@		m = meter type (0 = health, 1 = balance)
@		x = unused
@               n = ``no physics'' bit
@    note that the above two are commonly represented as a halfword in
@    the actual entries.  +4 is the lower-half of the halfword.
@ +6	hwrod	pad
@ }
@	word	ptr to sprite offset setup function
@	word	AI update function
@	word	human update function
@	word	collision handler
@	word	damage handler
@ 	asciiz	name
@ <word align>

	.section .rodata
	.align
	
	.include "game.inc"

.equ COLLIDABLE, (1<<7)
.equ BALANCE_METER, (1<<15)

	.global archetype_table
archetype_table:
0:
	.hword (sam-0b)>>2, (green_trooper-0b)>>2, (green_captain-0b)>>2
	.hword (green_sentry-0b)>>2, (ed_beast-0b)>>2, (blue_drone-0b)>>2
	.hword (balance_orb-0b)>>2, (green_ripper-0b)>>2, (green_maude-0b)>>2
	.hword (minos-0b)>>2, (stretcher-0b)>>2, (elevator-0b)>>2
	.hword (scientist-0b)>>2, (worm-0b)>>2, (sanibot-0b)>>2, (slime-0b)>>2
	.hword (white_ripper-0b)>>2, (ice_captain-0b)>>2, (ice_sentry-0b)>>2
	.hword (crow-0b)>>2, (joey-0b)>>2, (rob-0b)>>2, (jon-0b)>>2, (billy-0b)>>2
        .hword (guardcorpse-0b)>>2, (howard-0b)>>2, (riva-0b)>>2, (quinn-0b)>>2
	.hword (glenn-0b)>>2, (gertrude-0b)>>2, (bigfire-0b)>>2, (vortex-0b)>>2
	.hword (platform-0b)>>2, (crawler-0b)>>2, (tinybot-0b)>>2, (lilly-0b)>>2
	.hword (interceptor-0b)>>2, (shifter-0b)>>2, (cryobot-0b)>>2
	.hword (blue_trooper-0b)>>2, (blue_captain-0b)>>2, (blue_sentry-0b)>>2
	.hword (red_trooper-0b)>>2, (red_captain-0b)>>2, (red_sentry-0b)>>2
	.hword (black_trooper-0b)>>2, (black_captain-0b)>>2, (black_sentry-0b)>>2
	.hword (green_sniper-0b)>>2, (blue_sniper-0b)>>2, (red_sniper-0b)>>2
	.hword (black_sniper-0b)>>2, (daedelus-0b)>>2, (juno-0b)>>2, (black_steve-0b)>>2
	.hword (interceptorii-0b)>>2, (brownlilly-0b)>>2, (hostage1-0b)>>2
	.hword (hostage2-0b)>>2, (hostage3-0b)>>2, (icecrawler-0b)>>2 
	.hword (stomper-0b)>>2, (door-0b)>>2, (orbiter1-0b)>>2, (orbiter2-0b)>>2
	.hword (emperor-0b)>>2, (debris1-0b)>>2, (debris2-0b)>>2, (debris3-0b)>>2
	.hword (debris4-0b)>>2
	.align

	@ type 0 (Sam)
sam:	.byte 128		    @ mass
	.byte 24,24,24		    @ speed (easy,normal,hard)
	.byte 40,40,40  	    @ health/balance (e,n,h)
	.byte 2			    @ number of parts
	.word samlegs_spr	    @ sprites
	.hword PAL_SAM | COLLIDABLE | BALANCE_METER, 0
	.word sam_spr		    @ sprites
	.hword PAL_SAM,0	    @ flags
	.word offset_sam	    @ offset setup function
	.word ai_miller, human_sam
	.word 0, damage_sam
	.string "Sam"		    @ name
	.align

	@ type 1 (Green Trooper)
green_trooper:
	.byte 133			    @ mass
	.byte 16,20,24		    @ speed (easy,normal,hard)
	.byte 9,12,16		    @ health/balance (e,n,h)
	.byte 2			    @ number of parts
	.word guard_legs	    @ sprites
	.hword PAL_GUARDGREEN|COLLIDABLE,0
	.word guard_spr		    @ sprites
	.hword PAL_GUARDGREEN|COLLIDABLE,0
	.word offset_guard	    @ offset setup function
	.word ai_miller,0,0,damage_guard
	.string "Green Trooper"	    @ name
	.align

	@ type 2 (Green Captain)
green_captain:
	.byte 137	            @ mass
	.byte 12,16,20		    @ speed (easy,normal,hard)
	.byte 18,22,25		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word captain_spr	    @ sprites
	.hword PAL_GUARDGREEN|COLLIDABLE,0
	.word 0			    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Green Captain"	    @ name
	.align

	@ type 3 (Green Sentry)
green_sentry:
	.byte 176		    @ mass
	.byte 0,0,0		    @ speed (easy,normal,hard)
	.byte 25,30,40		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word turret_spr	    @ sprites
	.hword PAL_GUARDGREEN|COLLIDABLE,0
	.word 0			    @ offset setup function
	.word 0,0,0,damage_dumb
	.string "Green Sentry"	    @ name
	.align

	@ type 4 (ED Beast)
ed_beast:
	.byte 0			    @ mass
	.byte 12,16,20		    @ speed (easy,normal,hard)
	.byte 30,50,70		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word beast_spr		    @ sprites
	.hword PAL_ALPHA,0          @ flags
	.word 0			    @ offset setup function
	.word ai_beast,0,0,0
	.string "ED Beast"	    @ name
	.align

	@ type 5 (Blue Drone)
blue_drone:
	.byte 194		    @ mass
	.byte 12,16,20              @ 16,20,24
	.byte 25,30,35              @ health/balance (e,n,h)
	.byte 2			    @ number of parts
	.word drone_arm_spr         @ sprites
	.hword PAL_ROBOBLUE,0       @ flags
	.word drone_spr             @ sprites
	.hword PAL_ROBOBLUE | COLLIDABLE,0
	.word offset_steve          @ offset setup function
	.word ai_steve,0,0,damage_dumb
	.string "Blue SteveDroid"   @ name
	.align
	
	@ type 6 (Balance Orb)
balance_orb:
	.byte 0			    @ mass
	.byte 0,0,0		    @ speed (easy,normal,hard)
	.byte 40,30,20		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word orb_spr		    @ sprites
	.hword PAL_ALPHA|COLLIDABLE,0
	.word 0			    @ offset setup function
	.word ai_orb,0,collide_orb,0
	.string "Balance Orb"	    @ name
	.align

	@ type 7 (Green Ripper)
green_ripper:
	.byte 112		    @ mass
	.byte 48,64,76		    @ speed (easy,normal,hard)
	.byte 12,18,20		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word ripper_spr	    @ sprites
	.hword PAL_BIOGREEN|COLLIDABLE,0
	.word 0         	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Green Ripper"	    @ name
	.align

	@ type 8 (Green Maude)
green_maude:
	.byte 198		    @ mass
	.byte 48,64,72		    @ speed (easy,normal,hard)
	.byte 40,50,55		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word maude_spr		    @ sprites
	.hword PAL_BIOGREEN|COLLIDABLE,0          @ flags
	.word 0			    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Malicious Maude"   @ name
	.align

	@ type 9 (Minos)
minos:
	.byte 127		    @ mass
	.byte 30,30,30		    @ speed (easy,normal,hard)
	.byte 50,50,50		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word minos_spr	            @ sprites
	.hword PAL_MINOS|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word 0,0,0,damage_dumb
	.string "Minos"		    @ name
	.align

	@ type 10 (Stretcher)
stretcher:
	.byte 95	            @ mass
	.byte 30,30,30		    @ speed (easy,normal,hard)
	.byte 0,0,0		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word stretcher_spr	    @ sprites
	.hword PAL_SAM|COLLIDABLE,0
	.word 0			    @ offset setup function
	.word stretcher_update,0,stretcher_collider,0
	.string "Stretcher"	    @ name
	.align

	@ type 11 (Elevator)
elevator:
	.byte 192		    @ mass
	.byte 0,0,0		    @ speed (easy,normal,hard)
	.byte 0,0,0		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word elevator_spr	    @ sprites
	.hword PAL_ROBOBLUE,0       @ flags
	.word 0			    @ offset setup function
	.word 0,0,0,0
	.string "Elevator"	    @ name
	.align

	@ type 12 (Scientist)
scientist:
	.byte 129		    @ mass
	.byte 12,16,20		    @ speed (easy,normal,hard)
	.byte 8,8,8		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word scientist_spr         @ sprites
	.hword PAL_SAM|COLLIDABLE,0	    @ flags
	.word 0          	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Scientist"         @ name
	.align

	@ type 13 (Worm)
worm:
	.byte 104		    @ mass
	.byte 4,8,16		    @ speed (easy,normal,hard)
	.byte 20,25,30		    @ health/balance (e,n,h)
	.byte 1 		    @ number of parts
	.word worm_spr  	    @ sprites
	.hword PAL_BIOGREEN|COLLIDABLE,0       @ flags
	.word 0			    @ offset setup function
	.word ai_miller,0,ronald_collider,damage_dumb
	.string "RonaldWorm"        @ name
	.align

	@ type 14 (Sanibot)
sanibot:
	.byte 104		    @ mass
	.byte 4,8,16		    @ speed (easy,normal,hard)
	.byte 20,25,30		    @ health/balance (e,n,h)
	.byte 1 		    @ number of parts
	.word sanibot_spr  	    @ sprites
	.hword PAL_ROBOSANI,0       @ flags
	.word 0			    @ offset setup function
	.word 0,0,0,0
	.string "Sanitation Droid"  @ name
	.align

	@ type 15 (Danza)
slime:
	.byte 10		    @ mass
	.byte 4,8,16		    @ speed (easy,normal,hard)
	.byte 66,66,66		    @ health/balance (e,n,h)
	.byte 1 		    @ number of parts
	.word slime_spr  	    @ sprites
	.hword PAL_BIOGREEN|COLLIDABLE,0       @ flags
	.word 0			    @ offset setup function
	.word ai_beast,0,0,0
	.string "DANZA"  @ name
	.align

	@ type 16 (Ice Ripper)
white_ripper:
	.byte 112		    @ mass
	.byte 60,75,90		    @ speed (easy,normal,hard)
	.byte 20,25,30		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word ripper_spr	    @ sprites
	.hword PAL_BIOWHITE|COLLIDABLE,0	    @ flags
	.word 0			    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Ice Ripper"	    @ name
	.align

	@ type 17 (Cryo Trooper)
ice_captain:
	.byte 137	            @ mass
	.byte 12,16,20		    @ speed (easy,normal,hard)
	.byte 20,25,30		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word captain_spr	    @ sprites
	.hword PAL_GUARDICE|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Cryo Trooper"	    @ name
	.align
	
	@ type 18 (Cryo Sentry)
ice_sentry:
	.byte 176		    @ mass
	.byte 0,0,0		    @ speed (easy,normal,hard)
	.byte 30,35,40		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word turret_spr	    @ sprites
	.hword PAL_GUARDICE,0     @ flags
	.word 0			    @ offset setup function
	.word 0,0,0,0
	.string "Cryo Sentry"	    @ name
	.align

	@ type 19 (Crow)
crow:
	.byte 35		    @ mass
	.byte 50,50,50		    @ speed (easy,normal,hard)
	.byte 3,3,3		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word crow_spr		    @ sprites
	.hword PAL_GUARDGREEN,0     @ flags
	.word offset_crow	    @ offset setup function
	.word 0,brad_the_crow,0,0
	.string "Brad the Crow"	    @ name
	.align

	@ type 20 (Joey)
joey:
	.byte 126		    @ mass
	.byte 21,26,31		    @ speed (easy,normal,hard)
	.byte 15,20,25		    @ health/balance (e,n,h)
	.byte 2			    @ number of parts
	.word beta_legs	            @ sprites
	.hword PAL_GUARDGREEN|COLLIDABLE,0        @ flags
	.word joey_spr	            @ sprites
	.hword PAL_BGGREEN|COLLIDABLE,0	    @ flags
	.word offset_stacked      @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Corporal Joey"	    @ name
	.align

	@ type 21 (Rob)
rob:
	.byte 125		    @ mass
	.byte 19,24,29		    @ speed (easy,normal,hard)
	.byte 16,21,26		    @ health/balance (e,n,h)
	.byte 2			    @ number of parts
	.word beta_legs	            @ sprites
	.hword PAL_BGBLUE|COLLIDABLE,0        @ flags
	.word rob_spr	            @ sprites
	.hword PAL_BGBLUE|COLLIDABLE,0	    @ flags
	.word offset_stacked	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Private Rob"	    @ name
	.align

	@ type 22 (Jon)
jon:
	.byte 127		    @ mass
	.byte 19,24,29		    @ speed (easy,normal,hard)
	.byte 17,22,27		    @ health/balance (e,n,h)
	.byte 2			    @ number of parts
	.word beta_legs	            @ sprites
	.hword PAL_GUARDBLUE|COLLIDABLE,0
	.word jon_spr	            @ sprites
	.hword PAL_BGGREEN|COLLIDABLE,0
	.word offset_stacked	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Lieutenant Jon"    @ name
	.align

	@ type 23 (Billy the Trooper)
billy:
	.byte 133		    @ mass
	.byte 20,20,20		    @ speed (easy,normal,hard)
	.byte 50,50,50		    @ health/balance (e,n,h)
	.byte 2			    @ number of parts
	.word guard_legs	    @ sprites
	.hword PAL_BILLY|COLLIDABLE,0
	.word guard_spr		    @ sprites
	.hword PAL_BILLY|COLLIDABLE,0
	.word offset_guard	    @ offset setup function
	.word ai_miller,human_billy,0,damage_guard
	.string "Billy the Trooper" @ name
	.align


	@ type 24 (Guard Corpse)
guardcorpse:
	.byte 132		    @ mass
	.byte 0,0,0		    @ speed (easy,normal,hard)
	.byte 1,1,1		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word guardcorpse_spr	    @ sprites
	.hword PAL_GUARDGREEN,0     @ flags
	.word 0			    @ offset setup function
	.word 0,0,0,0
	.string "Private Rollmann"  @ name
	.align


	@ type 25 (Hjowordt)
howard:
	.byte 234		    @ mass
	.byte 0,0,0		    @ speed (easy,normal,hard)
	.byte 60,70,80  	    @ health/balance (e,n,h)
	.byte 3			    @ number of parts
	.word howard_end	   
	.hword PAL_BIOBROWN|COLLIDABLE,0
	.word howard_mid	   
	.hword PAL_BIOBROWN|COLLIDABLE,0
	.word howard_spr	   
	.hword PAL_BIOBROWN|COLLIDABLE,0
	.word offset_stacked	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Howard"	    @ name
	.align

	@ type 26 (Riva Machine)
riva:
	.byte 233		    @ mass
	.byte 60,70,80		    @ speed (easy,normal,hard)
	.byte 40,50,80   	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word riva_spr  	    @ sprites
	.hword PAL_ROBOBLUE|COLLIDABLE,0
	.word offset_stacked	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "R.I.V.A"	    @ name
	.align

	@ type 27 (quinn)
quinn:
	.byte 126		    @ mass
	.byte 25,25,25		    @ speed (easy,normal,hard)
	.byte 48,48,48		    @ health/balance (e,n,h)
	.byte 2			    @ number of parts
	.word beta_legs	            @ sprites
	.hword PAL_QUINN|COLLIDABLE,0
	.word quinn_spr	            @ sprites
	.hword PAL_QUINN|COLLIDABLE,0
	.word offset_quinn	    @ offset setup function
	.word ai_miller,human_quinn,0,damage_quinn
	.string "Quinn" 	    @ name
	.align

	@ type 28 (glenn)
glenn:
	.byte 150		    @ mass
	.byte 10,20,30		    @ speed (easy,normal,hard)
	.byte 28,38,48  	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word glenn_spr	            @ sprites
	.hword PAL_BIOBROWN|COLLIDABLE,0
	.word 0         	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Glenn" 	    @ name
	.align
	
	@ type 29 (Gertrude Crab thing)
gertrude:
	.byte 120		    @ mass
	.byte 15,20,25		    @ speed (easy,normal,hard)
	.byte 20,28,32  	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word gertrude_spr  	    @ sprites
	.hword PAL_BIOGREEN|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Gertrude"	    @ name
	.align

	@ type 30 (Fire! [Josh])
bigfire:
	.byte 0 		    @ mass
	.byte 0,0,0		    @ speed (easy,normal,hard)
	.byte 0,0,0     	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word bigfire_spr  	    @ sprites
	.hword PAL_FIRE,0	    @ flags
	.word 0			    @ offset setup function
	.word 0,0,0,0
	.string "Josh"	            @ name
	.align

	@ type 31 (Vortex)
vortex:
	.byte 0 		    @ mass
	.byte 0,0,0		    @ speed (easy,normal,hard)
	.byte 0,0,0     	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word vortex_spr  	    @ sprites
	.hword PAL_BETA,0	    @ flags
	.word 0			    @ offset setup function
	.word ai_vortex,0,0,0
	.string "Vortex"	    @ name
	.align

	@ type 32 (Platform)
platform:
	.byte 159 		    @ mass
	.byte 30,30,40		    @ speed (easy,normal,hard)
	.byte 40,30,20     	    @ health/balance (e,n,h) [secretly height]
	.byte 1			    @ number of parts
	.word platform_spr  	    @ sprites
	.hword PAL_ROBOBLUE,0	    @ flags
	.word 0			    @ offset setup function
	.word platform_handler,0,0,0
	.string "Platform"	    @ name
	.align
	

	@ type 33 (Crawler)
crawler:
	.byte 120		    @ mass
	.byte 15,20,25		    @ speed (easy,normal,hard)
	.byte 20,25,30  	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word crawler_spr  	    @ sprites
	.hword PAL_BIOGREEN|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Aleister Crawly"    @ name
	.align


	@ type 34 (Tinybot)
tinybot:
	.byte 120		    @ mass
	.byte 30,35,50		    @ speed (easy,normal,hard)
	.byte 3,5,8     	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word tinybot_spr  	    @ sprites
	.hword PAL_ROBOBLUE|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word glitter_kid_handler,0,0,damage_dumb
	.string "Ngaire's Glittering kid"	    @ name
	.align

	@ type 35 (Lillypain)
lilly:
	.byte 120		    @ mass
	.byte 15,20,25		    @ speed (easy,normal,hard)
	.byte 20,25,30  	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word lilly_spr  	    @ sprites
	.hword PAL_BIOGREEN|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Lillypain"	    @ name
	.align

	
	@ type 36 (interceptor)
interceptor:
	.byte 159		    @ mass
	.byte 30,40,60		    @ speed (easy,normal,hard)
	.byte 10,20,30  	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word interceptor_spr  	    @ sprites
	.hword PAL_ROBOBLUE|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "interceptor"	    @ name
	.align

	
	@ type 37 (Shifter)
shifter:
	.byte 234		    @ mass
	.byte 30,40,60		    @ speed (easy,normal,hard)
	.byte 70,80,100  	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word shifter_spr  	    @ sprites
	.hword PAL_ROBOCYAN|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Shifter"	    @ name
	.align

	
	@ type 38 (cryobot)
cryobot:
	.byte 232		    @ mass
	.byte 30,40,60		    @ speed (easy,normal,hard)
	.byte 80,90,100  	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word cryobot_spr  	    @ sprites
	.hword PAL_ROBOBLUE|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Cryobot"	    @ name
	.align

	
	@ type 39 (Blue Trooper)
blue_trooper:
	.byte 133			    @ mass
	.byte 16,20,24		    @ speed (easy,normal,hard)
	.byte 9,12,16		    @ health/balance (e,n,h)
	.byte 2			    @ number of parts
	.word guard_legs	    @ sprites
	.hword PAL_GUARDBLUE|COLLIDABLE,0
	.word guard_spr		    @ sprites
	.hword PAL_GUARDBLUE|COLLIDABLE,0
	.word offset_guard	    @ offset setup function
	.word ai_miller,0,0,damage_guard
	.string "Blue Trooper"	    @ name
	.align

	@ type 40 (Blue Captain)
blue_captain:
	.byte 137	            @ mass
	.byte 12,16,20		    @ speed (easy,normal,hard)
	.byte 18,22,25		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word captain_spr	    @ sprites
	.hword PAL_GUARDBLUE|COLLIDABLE,0
	.word 0			    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Blue Captain"	    @ name
	.align

	@ type 41 (Blue Sentry)
blue_sentry:
	.byte 176		    @ mass
	.byte 0,0,0		    @ speed (easy,normal,hard)
	.byte 25,30,40		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word turret_spr	    @ sprites
	.hword PAL_GUARDBLUE|COLLIDABLE,0
	.word 0			    @ offset setup function
	.word 0,0,0,damage_dumb
	.string "Blue Sentry"	    @ name
	.align

	@ type 42 (Red Trooper)
red_trooper:
	.byte 133			    @ mass
	.byte 16,20,24		    @ speed (easy,normal,hard)
	.byte 9,12,16		    @ health/balance (e,n,h)
	.byte 2			    @ number of parts
	.word guard_legs	    @ sprites
	.hword PAL_GUARDRED|COLLIDABLE,0
	.word guard_spr		    @ sprites
	.hword PAL_GUARDRED|COLLIDABLE,0
	.word offset_guard	    @ offset setup function
	.word ai_miller,0,0,damage_guard
	.string "Red Trooper"	    @ name
	.align

	@ type 43 (Red Captain)
red_captain:
	.byte 137	            @ mass
	.byte 12,16,20		    @ speed (easy,normal,hard)
	.byte 18,22,25		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word captain_spr	    @ sprites
	.hword PAL_GUARDRED|COLLIDABLE,0
	.word 0			    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Red Captain"	    @ name
	.align

	@ type 44 (Red Sentry)
red_sentry:
	.byte 176		    @ mass
	.byte 0,0,0		    @ speed (easy,normal,hard)
	.byte 25,30,40		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word turret_spr	    @ sprites
	.hword PAL_GUARDRED|COLLIDABLE,0
	.word 0			    @ offset setup function
	.word 0,0,0,damage_dumb
	.string "Red Sentry"	    @ name
	.align

	@ type 45 (Elite Trooper)
black_trooper:
	.byte 133			    @ mass
	.byte 16,20,24		    @ speed (easy,normal,hard)
	.byte 9,12,16		    @ health/balance (e,n,h)
	.byte 2			    @ number of parts
	.word guard_legs	    @ sprites
	.hword PAL_GUARDBLACK|COLLIDABLE,0
	.word guard_spr		    @ sprites
	.hword PAL_GUARDBLACK|COLLIDABLE,0
	.word offset_guard	    @ offset setup function
	.word ai_miller,0,0,damage_guard
	.string "Elite Trooper"	    @ name
	.align

	@ type 46 (Elite Captain)
black_captain:
	.byte 137	            @ mass
	.byte 12,16,20		    @ speed (easy,normal,hard)
	.byte 18,22,25		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word captain_spr	    @ sprites
	.hword PAL_GUARDBLACK|COLLIDABLE,0
	.word 0			    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Elite Captain"	    @ name
	.align

	@ type 47 (Elite Sentry)
black_sentry:
	.byte 176		    @ mass
	.byte 0,0,0		    @ speed (easy,normal,hard)
	.byte 25,30,40		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word turret_spr	    @ sprites
	.hword PAL_GUARDBLACK|COLLIDABLE,0
	.word 0			    @ offset setup function
	.word 0,0,0,damage_dumb
	.string "Elite Sentry"	    @ name
	.align


	@ type 48 (Green Sniper)
green_sniper:
	.byte 128	            @ mass
	.byte 8,10,15		    @ speed (easy,normal,hard)
	.byte 8,15,20		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word sniper_spr	    @ sprites
	.hword PAL_GUARDGREEN|COLLIDABLE,0
	.word 0			    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Green Sniper"	    @ name
	.align

	@ type 49 (Blue Sniper)
blue_sniper:
	.byte 128	            @ mass
	.byte 8,10,15		    @ speed (easy,normal,hard)
	.byte 8,15,20		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word sniper_spr	    @ sprites
	.hword PAL_GUARDBLUE|COLLIDABLE,0
	.word 0			    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Blue Sniper"	    @ name
	.align

	@ type 50 (Red Sniper)
red_sniper:
	.byte 128	            @ mass
	.byte 8,10,15		    @ speed (easy,normal,hard)
	.byte 8,15,20		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word sniper_spr	    @ sprites
	.hword PAL_GUARDRED|COLLIDABLE,0
	.word 0			    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Red Sniper"	    @ name
	.align

	@ type 51 (Elite Sniper)
black_sniper:
	.byte 128	            @ mass
	.byte 8,10,15		    @ speed (easy,normal,hard)
	.byte 8,15,20		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word sniper_spr	    @ sprites
	.hword PAL_GUARDBLACK|COLLIDABLE,0
	.word 0			    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Elite Sniper"	    @ name
	.align

	@ type 52 (Daedelus)
daedelus:
	.byte 137	            @ mass
	.byte 16,16,16		    @ speed (easy,normal,hard)
	.byte 60,60,60		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word daedelus_spr	    @ sprites
	.hword PAL_DAEDELUS|COLLIDABLE,0
	.word 0			    @ offset setup function
	.word 0,0,0,damage_dumb
	.string "Daedelus"	    @ name
	.align


	@ type 53 (Juno)
juno:
	.byte 125	            @ mass
	.byte 28,28,28		    @ speed (easy,normal,hard)
	.byte 55,55,55		    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word juno_spr	    @ sprites
	.hword PAL_JUNO|COLLIDABLE,0
	.word 0			    @ offset setup function
	.word 0,0,0,damage_dumb
	.string "Juno"	    @ name
	.align


	@ type 54 (Black Drone)
black_steve:
	.byte 194		    @ mass
	.byte 20,30,40              @ 16,20,24
	.byte 35,40,45              @ health/balance (e,n,h)
	.byte 2			    @ number of parts
	.word drone_arm_spr         @ sprites
	.hword PAL_ROBOBLACK,0       @ flags
	.word drone_spr             @ sprites
	.hword PAL_ROBOBLACK | COLLIDABLE,0
	.word offset_steve          @ offset setup function
	.word ai_steve,0,0,damage_dumb
	.string "Black SteveDroid"   @ name
	.align


	@ type 55 (interceptorII)
interceptorii:
	.byte 159		    @ mass
	.byte 60,70,80		    @ speed (easy,normal,hard)
	.byte 10,20,30  	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word interceptor_spr  	    @ sprites
	.hword PAL_ROBOBLACK|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Interceptor Mark II"	    @ name
	.align


	@ type 56 (Brown Lillypain)
brownlilly:
	.byte 120		    @ mass
	.byte 15,20,25		    @ speed (easy,normal,hard)
	.byte 30,35,40  	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word lilly_spr  	    @ sprites
	.hword PAL_BIOBROWN|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "Lillypain"	    @ name
	.align


	@ type 57 (Sitting victim)
hostage1:
	.byte 124		    @ mass
	.byte 1,1,1		    @ speed (easy,normal,hard)
	.byte 30,10,5   	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word sitting_victim_spr  	    @ sprites
	.hword PAL_BGGREEN|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word 0,0,victim_collider,0
	.string "Sitting Victim"    @ name
	.align


	@ type 58 (leaning victim)
hostage2:
	.byte 124		    @ mass
	.byte 1,1,1		    @ speed (easy,normal,hard)
	.byte 30,10,5   	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word leaning_victim_spr  	    @ sprites
	.hword PAL_BGRED|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word 0,0,victim_collider,0
	.string "Leaning Victim"    @ name
	.align


	@ type 59 (panting victim)
hostage3:
	.byte 124		    @ mass
	.byte 1,1,1		    @ speed (easy,normal,hard)
	.byte 30,10,5   	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word panting_victim_spr  	    @ sprites
	.hword PAL_BGBLUE|COLLIDABLE,0  @ flags
	.word 0         	    @ offset setup function
	.word 0,0,victim_collider,0
	.string "Panting Victim"    @ name
	.align

	@ type 60 (Ice Crawler)
icecrawler:
	.byte 120		    @ mass
	.byte 15,20,25		    @ speed (easy,normal,hard)
	.byte 20,25,30  	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word crawler_spr  	    @ sprites
	.hword PAL_BIOWHITE|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word ai_miller,0,0,damage_dumb
	.string "AleICEster Crawly"    @ name
	.align

	@ type 61 (Stomper Boss)
stomper:
	.byte 253		    @ mass
	.byte 15,20,25		    @ speed (easy,normal,hard)
	.byte 60,70,80  	    @ health/balance (e,n,h)
	.byte 5			    @ number of parts
	.word body_spr  	    @ sprites
	.hword PAL_ROBOBLUE|COLLIDABLE,0	 
	.word pivot_spr
	.hword PAL_ROBOBLUE,0	 
	.word barrels_spr  	
	.hword PAL_ROBOBLUE,0	 
	.word foot_spr  	
	.hword PAL_ROBOBLUE|COLLIDABLE,0	 
	.word foot_spr  	
	.hword PAL_ROBOBLUE|COLLIDABLE,0	 
	.word 0         	    @ offset setup function
	.word 0,0,0,damage_dumb
	.string "Stomper"    @ name
	.align


	@ type 62 (Door)
door:
	.byte 135		    @ mass
	.byte 0,0,0		    @ speed (easy,normal,hard)
	.byte 1,1,1     	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word door_spr  	    @ sprites
	.hword PAL_ROBOBLUE|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word 0,0,0,0
	.string "Donny Doordoor"    @ name
	.align


	@ type 63 (Orbiter Drone)
orbiter1:
	.byte 130		    @ mass
	.byte 20,20,20		    @ speed (easy,normal,hard)
	.byte 1,1,1     	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word orbiter1_spr  	    @ sprites
	.hword PAL_ROBOCYAN|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word 0,0,0,0
	.string "Orbiter Drone Alpha"    @ name
	.align


	@ type 64 (Orbiter Drone)
orbiter2:
	.byte 130		    @ mass
	.byte 20,20,20		    @ speed (easy,normal,hard)
	.byte 1,1,1     	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word orbiter2_spr  	    @ sprites
	.hword PAL_ROBOCYAN|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word 0,0,0,0
	.string "Orbiter Drone Beta"    @ name
	.align


	@ type 65 (EMPEROR)
emperor:
	.byte 0			    @ mass
	.byte 16,20,24		    @ speed (easy,normal,hard)
	.byte 80,90,100		    @ health/balance (e,n,h)
	.byte 2			    @ number of parts
	.word emperor_bot	    @ sprites
	.hword PAL_ALPHA|COLLIDABLE,0
	.word emperor_top	    @ sprites
	.hword PAL_ALPHA|COLLIDABLE,0
	.word offset_stacked	    @ offset setup function
	.word ai_beast,0,0,0
	.string "EMPEROR"	    @ name
	.align


	@ type 66 (Big Red Debris)
debris1:
	.byte 211		    @ mass
	.byte 10,10,10		    @ speed (easy,normal,hard)
	.byte 1,1,1      	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word debris1_spr  	    @ sprites
	.hword PAL_ROBORED|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word 0,0,0,0
	.string "Metal Chunk"    @ name
	.align


	@ type 67 (Big Silver Debris)
debris2:
	.byte 210		    @ mass
	.byte 10,10,10		    @ speed (easy,normal,hard)
	.byte 1,1,1      	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word debris2_spr  	    @ sprites
	.hword PAL_ROBORED|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word 0,0,0,0
	.string "Debris Chunk"    @ name
	.align


	@ type 68 (Small Red Debris)
debris3:
	.byte 176		    @ mass
	.byte 10,10,10		    @ speed (easy,normal,hard)
	.byte 1,1,1      	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word debris3_spr  	    @ sprites
	.hword PAL_ROBORED|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word 0,0,0,0
	.string "Piece of Apparatus"    @ name
	.align

	@ type 69 (Small Silver Debris)
debris4:
	.byte 177		    @ mass
	.byte 10,10,10		    @ speed (easy,normal,hard)
	.byte 1,1,1      	    @ health/balance (e,n,h)
	.byte 1			    @ number of parts
	.word debris4_spr  	    @ sprites
	.hword PAL_ROBORED|COLLIDABLE,0	    @ flags
	.word 0         	    @ offset setup function
	.word 0,0,0,0
	.string "Piece of Debra"    @ name
	.align


@ EOF archetypes.s
