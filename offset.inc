@ offset.inc -- offset macros
@
@ $Id: offset.inc,v 1.1 2002/11/28 13:27:29 tek Exp $



.macro two_part_anim_m bottom, top
	ldrb r0, [r5]
	mov r1, #\bottom
    	bl sprite_setanim
	add r5, r5, #4
	ldrb r0, [r5]
	mov r1, #\top
    	bl sprite_setanim
.endm

@ Really this should be called two_part_anim_with_override_m.
.macro two_part_anim_with_attack_m bottom, top
	ldrb r0, [r5]
	mov r1, #\bottom
    	bl sprite_setanim
	add r5, r5, #4
	ldrb r0, [r5]
	cmp r8, #0
	moveq r1, #\top
	movne r1, r8
    	bl sprite_setanim
.endm

@ vim: syn=asm
