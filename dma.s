@ dma -- routines to harness hardware DMA.
@ Convergence
@ Copyright Pureplay Games / 2002
@
@ $Id: dma.s,v 1.5 2002/11/16 03:17:12 tek Exp $

	.section .text
	.arm
	.align
	.include "gba.inc"
	.include "dma.inc"

@ dma_copy32(dst, src, len)
@   Does a 32-bit copy using DMA channel 3.
@   {dst} and {src} must be word-aligned.  {len} is in bytes.
@
	.global dma_copy32
dma_copy32:
	dma_copy32_m
	bx lr
@ EOR dma_copy32


@ dma_copy16(dst, src, len)
@   Does a 16-bit copy using DMA channel 3.
@   {dst} and {src} must be halfword-aligned.  {len} is in bytes.
@
	.global dma_copy16
dma_copy16:
	dma_copy16_m
	bx lr
@ EOR dma_copy16

@ EOF dma.s
