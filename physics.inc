
@ Fun constants.
.equ X_TERMINAL_VELOCITY,24
.equ Y_TERMINAL_VELOCITY,40
.equ GRAVITY,16


@ Segment tree format:
@   0	hword	left branch (relative pointer >> 2, 0 = NULL)
.equ SEGNODE_LEFT, 0
@   2	hword	right branch (as per left)
.equ SEGNODE_RIGHT, 2
@   4	hword	span start
.equ SEGNODE_XLEFT, 4
@   6	hword	span end
.equ SEGNODE_XRIGHT, 6
@   8		lines sorted by maximal y coordinate, stored as hwords
@		which are indexes into the line bank.  0 indicates the
@		end of the list.
.equ SEGNODE_LINES, 8

@ Runtime segment format:
@   0	hword	x1
.equ SEGRT_X1,0
@   2	hword	y1
.equ SEGRT_Y1,2
@   4	hword	x2
.equ SEGRT_X2,4
@   6	hword	y2
.equ SEGRT_Y2,6
@   8	byte	friction
.equ SEGRT_FRICTION,8
@   9	byte	type
.equ SEGRT_TYPE,9
@   10  hword   pad
@   12	XXX WARNING: be careful if this ever changes, many multiplies
@	in the code have been optimized into two adds.
.equ SEGRT_SIZE, 12

@ Constants for segment types
@   uuuu uuuu  bahf lpxy
@	y = collide if v_y cmp 0, (when 0, cmp = >, else cmp = <)
@	x = collide if v_x cmp 0, (when 0, cmp = >, else cmp = <)
@	p = passable
@	l = ladder
@	f = fatal
@       h = painful
@       a = exists in alpha world
@       b = exists in beta world
@	u = unused
@
.equ SEGTYPE_FLAG_Y,1
.equ SEGTYPE_FLAG_X,2
.equ SEGTYPE_FLAG_PASS,4
.equ SEGTYPE_FLAG_LADDER,8
.equ SEGTYPE_FLAG_FATAL,16
.equ SEGTYPE_FLAG_PAINFUL,32
.equ SEGTYPE_FLAG_ALPHA,64
.equ SEGTYPE_FLAG_BETA,128

@ EOF physics.inc vim: syn=asm
