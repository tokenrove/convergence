@ interrupt -- hardware interrupt manager.
@ Convergence
@ Copyright Pureplay Games / 2002
@ author: tek
@
@ $Id: interrupt.s,v 1.8 2002/11/27 15:42:53 tek Exp $

	.section .ewram
	.align

.equ intr_nhooks, 16
intr_hook_list: .skip intr_nhooks*4

	.section .text
	.arm
	.align
	.include "gba.inc"

@ intr_init(void)
@   Initializes the interrupt manager.  Disables interrupts but enables
@   the master interrupt and installs intr_handler.
@
	.global intr_init
intr_init:
	@ Wipe the list of hooks.
	ldr r0, =intr_hook_list
	mov r1, #intr_nhooks
	mov r2, #0
0:	str r2, [r0], #4
	subs r1, r1, #1
	bne 0b

	@ Put our handler in place.
	ldr r0, =0x3007ffc
	ldr r1, =intr_handler
	str r1, [r0]

	@ Set IE blank.
	ldr r0, =REG_IE
	mov r1, #0
	strh r1, [r0]
	@ Enable master interrupt flag.
	ldr r0, =REG_IME
	mov r1, #1
	strh r1, [r0]
	@ Return.
	bx lr
@ EOR intr_init


@ intr_shutdown(void)
@   Shuts down the interrupt system.
	.global intr_shutdown
intr_shutdown:
	@ Disable master interrupt flag.
	ldr r0, =REG_IME
	mov r1, #0
	strh r1, [r0]
	@ Set IE blank.
	ldr r0, =REG_IE
	mov r1, #0
	strh r1, [r0]
	@ Return.
	bx lr
@ EOR intr_shutdown


@ intr_enable(interrupt, handler)
@   Enables the interrupt and uses {handler} to handle it.
@
	.global intr_enable
intr_enable:
	@ XXX for debug reasons we probably want to check
	@ if we're replacing an existing handler with this.

	@ Store the handler.
	ldr r2, =intr_hook_list
	@ assert(r0 < intr_nhooks)
#ifndef NDEBUG
	cmp r0, #intr_nhooks
	bge abort
#endif
	str r1, [r2, r0, lsl #2]

	@ Enable the interrupt.
	ldr r2, =REG_IE
	ldrh r3, [r2]
	mov r1, #1
	orr r3, r3, r1, lsl r0
	strh r3, [r2]

	bx lr
@ EOR intr_enable


@ intr_disable(interrupt)
@   Disables the interrupt and sets its handler to NULL.
@
	.global intr_disable
intr_disable:
	@ Disable the interrupt.
	ldr r2, =REG_IE
	ldrh r3, [r2]
	mov r1, #1
	bic r3, r3, r1, lsl r0
	strh r3, [r2]

	@ Wipe the handler.
	ldr r2, =intr_hook_list
	@ assert(r0 < intr_nhooks)
#ifndef NDEBUG
	cmp r0, #intr_nhooks
	bge abort
#endif
	mov r1, #0
	str r1, [r2, r0, lsl #2]

	@ Return.
	bx lr
@ EOR intr_disable


	.section .iwram_code, "ax", %progbits
	.arm
	.align

@ intr_handler(void)
@   Called when an interrupt occurs.  Multiplexes the interrupts to any
@   hooked functions.
@
@ XXX was replaced with JeffF's handler.  needs improvement.
@
	.global intr_handler
intr_handler:
                                         @ Multiple interrupts support
        mov     r2, #0x4000000           @ REG_BASE
        ldr     r3, [r2,#0x200]!         @ r2 = IE : r3 = IF|IE
        ldrh    r1, [r2, #0x8]           @ r1 = IME
        mrs     r0, spsr
        stmfd   sp!, {r0-r2,lr}          @ {spsr, IME, REG_IE, lr}  // IF|IE

        mov     r0, #1                   @ IME = 1 (To permit multiple interrupts if
                                         @ an interrupt occurs)
        strh    r0, [r2, #0x8]
        and     r1, r3, r3, lsr #16      @ r1 = IE & IF
        ldr     r12, =intr_hook_list

        ands    r0, r1, #1               @ V-blank interrupt
        bne     jump_intr
        add     r12,r12, #4
        ands    r0, r1, #2               @ H-blank interrupt
        bne     jump_intr
        add     r12,r12, #4
        ands    r0, r1, #4               @ V-counter interrupt
        bne     jump_intr
        add     r12,r12, #4
        ands    r0, r1, #8               @ Timer 0 interrupt
        bne     jump_intr
        add     r12,r12, #4
        ands    r0, r1, #0x10            @ Timer 1 interrupt
        bne     jump_intr
        add     r12,r12, #4
        ands    r0, r1, #0x20            @ Timer 2 interrupt
        bne     jump_intr
        add     r12,r12, #4
        ands    r0, r1, #0x40            @ Timer 3 interrupt
        bne     jump_intr
        add     r12,r12, #4
        ands    r0, r1, #0x80            @ Serial Communication Interrupt
        bne     jump_intr
        add     r12,r12, #4
        ands    r0, r1, #0x100           @ DMA 0 interrupt
        bne     jump_intr
        add     r12,r12, #4
        ands    r0, r1, #0x200           @ DMA 1 interrupt
        bne     jump_intr
        add     r12,r12, #4
        ands    r0, r1, #0x400           @ DMA 2 interrupt
        bne     jump_intr
        add     r12,r12, #4
        ands    r0, r1, #0x800           @ DMA 3 interrupt
        bne     jump_intr
        add     r12,r12, #4
        ands    r0, r1, #0x1000          @ Key interrupt
        bne     jump_intr
        add     r12,r12, #4
        ands    r0, r1, #0x2000          @ Cart interrupt

jump_intr:
        strh    r0, [r2, #2]             @ Clear IF

@ Enable multiple interrupts & switch to system

        mrs     r3, cpsr
        bic     r3, r3, #0xdf            @ \__
        orr     r3, r3, #0x1f            @ /  --> Enable IRQ & FIQ. Set CPU mode to System.
        msr     cpsr, r3

        ldr     r0, [r12]

        stmfd   sp!, {lr}
        adr     lr, IntrRet
        bx      r0
IntrRet:
        ldmfd   sp!, {lr}

@ Disable multiple interrupts & switch to IRQ Mode

        mrs     r3, cpsr
        bic     r3, r3, #0xdf            @ \__
        orr     r3, r3, #0x92            @ /  --> Disable IRQ. Enable FIQ. Set CPU mode to IRQ.
        msr     cpsr, r3

        ldmfd   sp!, {r0-r2,lr}          @ {spsr, IME, REG_IE, lr}  //IF|IE
@        strh    r3,  [r2]                @ set IE
        strh    r1,  [r2, #0x8]          @ restore REG_IME
        msr     spsr, r0                 @ restore spsr
        bx      lr
@ EOR intr_handler

	.pool

@ EOF interrupt.s
