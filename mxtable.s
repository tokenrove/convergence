@ mxtable -- music table
@
@ $Id: mxtable.s,v 1.1 2002/11/27 15:42:53 tek Exp $


        .global music_table
music_table:
        .word song_crazy_quest, 0

song_crazy_quest:
        .word instr_standard_sqr0, instr_standard_sqr1
        .word instr_standard_noise, instr_standard_samples
        .word song_crazy_quest_data
        .string "Tony D's Crazy Quest"
        .align

@ EOF mxtable.s
