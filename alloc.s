@ alloc -- General memory allocation module.
@ Convergence
@ Copyright Pureplay Games / 2002
@
@ $Id: alloc.s,v 1.1 2002/08/25 00:22:43 tek Exp $

	.section .ewram
	.align

.equ ALLOC_WORDS, 32768/4
base_ptr: .skip ALLOC_WORDS*4
@ Offset of size field
.equ PTR_SIZE, 0
@ Offset of link field
.equ PTR_LINK, 2

	.section .text
	.arm
	.align

@ void ewram_init(void)
@
	.global ewram_init
ewram_init:
	ldr r1, =base_ptr
	mov r2, #0
	strh r2, [r1, #PTR_SIZE]
	mov r2, #1
	strh r2, [r1, #PTR_LINK]
	
	add r1, r1, #4		    @ we use element 0 as \Lambda
	mov r2, #ALLOC_WORDS
	sub r2, r2, #2		    @ 1 for \Lambda, 1 for avail
	strh r2, [r1, #PTR_SIZE]
	mov r2, #0
	strh r2, [r1, #PTR_LINK]

	bx lr
@ EOR ewram_init


@ ptr ewram_alloc(amount)
@
	.global ewram_alloc
ewram_alloc:
	stmfd sp!, {r4-r5}

	add r0, r0, #7		    @ 4 for ctrl info, 3 for alignment
	mov r0, r0, lsr #2

	ldr r1, =base_ptr
	mov r2, #0		    @ Q <- LOC(AVAIL)
@ {
0:	ldr r3, [r1, r2]	    @ \ P <- LINK(Q)
	movs r3, r3, lsr #16	    @ /

	ldreq r0, =msg_outofram	    @ \ abort if P = \Lambda
	beq abort		    @ /

	mov r3, r3, lsl #2
	ldrh r4, [r1, r3]	    @ \ SIZE(P) >= N?
	subs r4, r4, r0		    @ / [K <- SIZE(P) - N]
	movlt r2, r3		    @ Q <- P
	blt 0b
@ }
	stmfd sp!, {r0}
	ldreq r0, [r1, r3]
	moveq r0, r0, lsr #16
	ldreqh r5, [r1, r2]
	orreq r0, r5, r0, lsl #16
	streq r0, [r1, r2]
	ldmfd sp!, {r0}

	add r0, r1, r3
	strneh r4, [r0]		    @ SIZE(P) <- K
	add r0, r0, r4, lsl #2
	add r0, r0, #4		    @ skip ctrl information
	ldmfd sp!, {r4-r5}
	bx lr
@ EOR ewram_alloc


@ void ewram_free(ptr)
@
	.global ewram_free
ewram_free:
	bx lr
@ EOR ewram_free


	.section .rodata
	.align

msg_outofram: .string "alloc: out of ewram!"

@ EOF alloc.s
