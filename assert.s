@ assert -- routines for debugging.
@ Convergence
@ Copyright Pureplay Games / 2002
@ Julian Squires <tek>
@
@ $Id: assert.s,v 1.9 2002/12/09 13:09:29 tek Exp $


@ ::<u4######################99V"~-:: ~9W##L       ~  ~ ~~G###
@ ~:_44###################U+~   _;;__ ~ :Q#%` ~ ~ ~  ~ ~ ~l###
@  <xaE#################D:  ~     89QQ##QU#E#`   ~{#} ~ ~ ~###
@ ~~vuWE#Q##E#E##E##E##S+`~   _     :=ug#QQ#Es;{;z##I ~  ~~G##
@  ~qx"7+^"77V7U###E##EI-~ _  ~  igs#####E###&vG##E#I ~ ~ ~l##
@  ~~  ~ ~     ~dQ#####({iS(g#####EK######E#Er:j#E#QZ ~  ~:l##
@     ~_s;_~ ~ ~~"9E#EQQ##%Q#WQE8UQZ#E#E#E###o(v3###E ~ ~~ l##
@  ~ ~{       _~<. 3####E#Emsos;gQ#########EQy=(<#E#1 _ ~ ~j##
@        0   ~d#gr="##E##############E#E#E###w=v:7V~  ~  ~  ~G
@  ~~~      gQ###Za:#E##E#E#E##E####E######EEno(v     ~  ~ ~ ~
@  ~<s;_jZs#E####E0:Q##E######E###E###E#E#BdQna=(  ~ ~  ~  _ ~
@ ~ {4#Qsr<7qgQE#Dx:4####E#E#E##Emg2QE###EBxdZAoc~[    ~ ~QZ^u
@ ~ ldEE#E#Q#E###Zs`d##E#######E##E#ZSVGE##n?QQcv Q_~ ~ _;Q#mr
@ _~7v#E#EE#E###E#Q:#####E#E#E###E##E#s_"WQA(Q#r^~{u`~ _QEQ##z
@ g_ <<EE##E#E#E###SQ###E####W+l###E####Q.QZ`Q#> ~~A:(<#QY4##;
@ #s ~~+NE##E####EErG#EE##EY"=z##E####Y<QhQ&~Q#:~ oA>"<#m>lFQE
@ ##)~~~l##E##E#E#"<~7UEEEr g###E####f~Q#QEk<E#`~ u4:q:ED[dE#B
@ #D+~ ~ dQ##E###Es ~ ~ ~~~#####EEY+ <##E##1{ET ~~lA:l_#Z;~i#E
@ ~` ~  ~~7U9UQ#EBUw_____ia###EEV"`  #E###E)dc( ~{vv:{>4Bt_GEU
@ ~ ~  ~  ~e::GQQQx4Zg####E##EY-    h#E#E##=a=^ ~QS==j_QZp<G#Q
@   ~   ~  {Qm<c<-(9\##|V7|##/     Q#E###EQ=j: ~uQxs>l dm> jQ#
@ __  ~  ~ ~NZ;Qs;_   \|  |/     #Q#E###E#&(a^~_GQAA>l l!'~v4G
@ ^-~ ~ ~  ~~7#Q#EEg;__sssssgE#E#E####E###D<: ~jQBe0:v~ak=j[qZ
@ 0v_ ~   ~   ~9#EEEQs"u;uQ####U?i#E#E##E#e~ ~ d#Qk4:C<D7+ dhQ
@ 0q;_ ~ ~  ~ ~ "9QmxQu./777+Vo;z#EE###EQ#> ~_jQ##AQ~p~Qg; lGe
@ AQex:       ~ ~ +WhaaKnss;Q#E###E#E#E###` ~{q###Qv<+~WE#;~ Q
@ #EQw'  ~ ~ ~   ~  <44QZQE####E#######EQ:  <Q###EQ~{`"#k: ~QD
@ Qg#? ~    ~  ~  ~ ~^0#Q##E##E##E#EEEEY"  _zQ###AS i_=#Br+~3A
@ #Ed[   ~ ~  ~  ~ ~  ~GDWQEEE#E####EQ8` ~ <A#E#EA[~n<>{#I <~Q
@ #ED: ~ ~_  ~  ~    ~ ~~v:"9QEEEE4ES+   ~~u#E#EQA>~aQZ2Eb <=4
@
@ I'M WATCHING YOU!

	.section .text
	.arm
	.align
	.include "gba.inc"

@ abort(msg)
@   Bring the system down hard.  Display the message specified and
@   sit on it.  Never returns.
@
	.global abort
abort:	
	stmfd sp!, {r0,lr}

	@ Turn off interrupts immediately.
	ldr r1, =REG_IME
	strh r1, [r1]

	bl gfx_set_mode_1
	ldr r0, =maiden_palette
	bl gfx_set_spr_palette

	ldr r0, =maiden_font
	bl font_init

	bl font_clear
	ldmfd sp!, {r0,lr}
	mov r1, #0
	mov r2, #0
	bl font_paintstring

0:	bal 0b
@ EOR abort


@ abort_lr
@   Dump value of LR to display
	.global abort_lr
abort_lr:
	mov r0, lr
	stmfd sp!, {r0,lr}

	@ Turn off interrupts immediately.
	ldr r1, =REG_IME
	strh r1, [r1]

	bl gfx_set_mode_1
	ldr r0, =maiden_palette
	bl gfx_set_spr_palette

	ldr r0, =maiden_font
	bl font_init

	bl font_clear
	ldmfd sp!, {r1,lr}

	ldr r0, =buffer
	mov r2, #'l'
	strb r2, [r0], #1
	mov r2, #'u'
	strb r2, [r0], #1
	mov r2, #'r'
	strb r2, [r0], #1
	mov r2, #'u'
	strb r2, [r0], #1
	mov r2, #':'
	strb r2, [r0], #1
	mov r2, #' '
	strb r2, [r0], #1

	ldr r3, =xlat
	mov r4, #32
0:	sub r4, r4, #4
	mov r2, r1, lsr r4
	and r2, r2, #0xf
	ldrb r2, [r3, r2]
	strb r2, [r0], #1
	cmp r4, #0
	bne 0b

	mov r1, #0
	strb r1, [r0]

	ldr r0, =buffer
	mov r1, #0
	mov r2, #0
	bl font_paintstring

1:	bal 0b
	bal abort_digits
@ EOR abort_lr


@ abort_digits(number)
@   Bring the system down hard.  Display the numbers specified and
@   sit on it.  Never returns.
@
	.global abort_digits
abort_digits:
	stmfd sp!, {r0,lr}

	@ Turn off interrupts immediately.
	ldr r1, =REG_IME
	strh r1, [r1]

	bl gfx_set_mode_1
	ldr r0, =maiden_palette
	bl gfx_set_spr_palette

	ldr r0, =maiden_font
	bl font_init

	bl font_clear
	ldmfd sp!, {r1,lr}

	ldr r0, =buffer
	mov r2, #'g'
	strb r2, [r0], #1
	mov r2, #'u'
	strb r2, [r0], #1
	mov r2, #'r'
	strb r2, [r0], #1
	mov r2, #'u'
	strb r2, [r0], #1
	mov r2, #':'
	strb r2, [r0], #1
	mov r2, #' '
	strb r2, [r0], #1

	ldr r3, =xlat
	mov r4, #32
0:	sub r4, r4, #4
	mov r2, r1, lsr r4
	and r2, r2, #0xf
	ldrb r2, [r3, r2]
	strb r2, [r0], #1
	cmp r4, #0
	bne 0b

	mov r1, #0
	strb r1, [r0]

	ldr r0, =buffer
	mov r1, #0
	mov r2, #0
	bl font_paintstring

1:	bal 0b
@ EOR abort_digits

	.section .rodata
	.align

xlat:	.byte '0','1','2','3','4','5','6','7','8','9'
	.byte 'a','b','c','d','e','f'

	.section .ewram
	.align

buffer: .skip 30

@ EOF assert.s
