@ timer -- hardware timer management.
@
@ $Id: timer.s,v 1.4 2002/11/27 15:42:53 tek Exp $
@

	.section .text
	.arm

	.include "gba.inc"

	.global timer_init
timer_init:
        @ Setup timer 2
        ldr r0, =REG_TM2DAT
        mov r1, #0xC10000
        str r1, [r0]
	bx lr
@ EOR timer_init


@
@ timer_setcount(timer, count)
@
	.global timer_setcount
timer_setcount:
        ldr r2, =REG_TM0DAT
        add r2, r2, r0, lsl #2
        strh r1, [r2]
	bx lr
@ EOR timer_setcount


@
@ prof_start
@   start gathering profiling information
@
	.global prof_start
prof_start:
	ldr r0, =REG_TM3DAT
	mov r1, #0b10000011 << 16
	str r1, [r0]
	ldr r0, =prof_dat
	mov r1, #0
	str r1, [r0]
	ldr r0, =prof_cnt
	mov r1, #0
	str r1, [r0]
	bx lr
@ EOR prof_start

@
@ prof_gather
@
	.global prof_gather
prof_gather:
	ldr r0, =REG_TM3DAT
	mov r1, #0b10000011 << 16
	str r1, [r0]
	bx lr
@ EOR prof_gather


@
@ prof_inc
@
	.global prof_inc
prof_inc:
	ldr r0, =REG_TM3DAT
	ldrh r1, [r0]
	ldr r0, =prof_dat
	ldr r2, [r0]
	add r2, r2, r1
	str r2, [r0]
	ldr r0, =prof_cnt
	ldr r1, [r0]
	add r1, r1, #1
	str r1, [r0]
	cmp r1, #1024
	bne 0f
	mov r0, r2, lsr #10
	bal abort_digits
0:	bx lr
@ EOR prof_inc


	.section .ewram

prof_dat: .skip 4
prof_cnt: .skip 4

@ EOF timer.s
