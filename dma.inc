@ dma.inc
@ DMA macros
@

.macro dma_copy32_m
	ldr r3, =REG_DMA3SRC
	str r1, [r3], #4
	str r0, [r3], #4
	mov r2, r2, lsr #2
	strh r2, [r3], #2
	mov r0, #0x8400
	strh r0, [r3]
.endm

.macro dma_copy16_m
	ldr r3, =REG_DMA3SRC
	str r1, [r3], #4
	str r0, [r3], #4
	mov r2, r2, lsr #1
	strh r2, [r3], #2
	mov r0, #0x8000
	strh r0, [r3]
.endm

@ EOF dma.inc  vim: syn=asm
