@ palettes -- the master actor palette table.
@ $Id: palettes.s,v 1.17 2002/12/13 20:52:31 retsyn Exp $
@

	.section .rodata
	.align

.global palette_table
palette_table:
	@ palette 0 (alpha)
	.incbin "palettes/alpha.pal"
	@ palette 1 (beta)
	.incbin "palettes/beta.pal"
	@ palette 2 (Sam)
	.incbin "palettes/sam.pal"
	@ palette 3 (laser)
	.incbin "palettes/laser.pal"
	@ palette 4 (Cyan Robot)
	.incbin "palettes/robo_cyan.pal"
	@ palette 5 (Green BioOrganism)
	.incbin "palettes/bio_green.pal"
	@ palette 6 (Brown BioOrganism)
	.incbin "palettes/bio_brown.pal"
	@ palette 7 (Blue Robot)
	.incbin "palettes/robo_blue.pal"
	@ palette 8 (Red Robot)
	.incbin "palettes/robo_red.pal"
	@ palette 9 (Black Robot)
	.incbin "palettes/robo_black.pal"
	@ palette 10 (Ice Guard)
	.incbin "palettes/guard_ice.pal"
	@ palette 11 (White BioOrganism)
	.incbin "palettes/bio_white.pal"
	@ palette 12 (Billy)
	.incbin "palettes/billy.pal"
	@ palette 13 (Fire)
	.incbin "palettes/fire.pal"
	@ palette 14 (Minos)
	.incbin "palettes/minos.pal"
	@ palette 15 (Sanitation Robot)
	.incbin "palettes/robo_sani.pal"
	@ palette 16 (Rose Robot)
	.incbin "palettes/robo_rose.pal"
	@ palette 17 (White Robot)
	.incbin "palettes/robo_white.pal"
	@ palette 18 (Black BioOrganism)
	.incbin "palettes/bio_black.pal"
	@ palette 19 (Balance Meter)
	.incbin "palettes/meter.pal"
	@ palette 20 (Balance meter slider)
	.incbin "palettes/jewel.pal"
	@ palette 21 (Juno)
	.incbin "palettes/juno.pal"
	@ palette 22 (Daedelus)
	.incbin "palettes/daedelus.pal"
	@ palette 23 (Green Guard)
	.incbin "palettes/guard_green.pal"
	@ palette 24 (Blue Guard)
	.incbin "palettes/guard_blue.pal"
	@ palette 25 (Red Guard)
	.incbin "palettes/guard_red.pal"
	@ palette 26 (Black Guard)
	.incbin "palettes/guard_black.pal"
	@ palette 27 (Beta guard blue)
	.incbin "palettes/betaguard_blue.pal"
	@ palette 28 (Beta guard red)
	.incbin "palettes/betaguard_red.pal"
	@ palette 29 (Green Beta Guard)
	.incbin "palettes/betaguard_green.pal"
	@ palette 30 (Quinn)
	.incbin "palettes/quinn.pal"
        @ palette 31 (Health meter contents)
        .incbin "palettes/healthmeter.pal"
        @ palette 32 (Health meter tube)
        .incbin "palettes/healthtube.pal"

@ EOF palettes.s
