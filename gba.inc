@
@ GBA symbolic definitions
@

@ Video constants
.equ SCREEN_WIDTH,  240
.equ SCREEN_HEIGHT, 160

@ Memory addresses
.equ ewram_base,    0x2000000
.equ ewram_end,	    0x2040000
.equ iwram_base,    0x3000000
.equ reg_base,	    0x4000000
.equ REG_DISPCNT,   0x4000000	    @ Display control
.equ REG_STAT,	    0x4000004	    @ LCD draw status, interrupts
.equ REG_VCOUNT,    0x4000006	    @ LCD vertical draw count

.equ REG_BG0,	    0x4000008	    @ Background 0 control
.equ REG_BG1,	    0x400000A	    @ Background 1 control
.equ REG_BG2,	    0x400000C	    @ Background 2 control
.equ REG_BG3,	    0x400000E	    @ Background 3 control
.equ REG_BG0SCX,    0x4000010	    @ Background 0 horizontal scroll
.equ REG_BG0SCY,    0x4000012	    @ Background 0 vertical scroll
.equ REG_BG1SCX,    0x4000014	    @ Background 1 horizontal scroll
.equ REG_BG1SCY,    0x4000016	    @ Background 1 vertical scroll
.equ REG_BG2SCX,    0x4000018	    @ Background 2 horizontal scroll
.equ REG_BG2SCY,    0x400001a	    @ Background 2 vertical scroll
.equ REG_BG3SCX,    0x400001c	    @ Background 3 horizontal scroll
.equ REG_BG3SCY,    0x400001e	    @ Background 3 vertical scroll

.equ REG_MOSAIC,    0x400004C	    @ Mosaic control.
.equ REG_BLDCNT,    0x4000050	    @ Blend control.
.equ REG_BLDALPHA,  0x4000052	    @ Alpha blend amount.
.equ REG_BLDLUMA,   0x4000054	    @ Luma blend amount.

.equ REG_SQR0CNT,   0x4000060       @ Square wave 0 channel control.
.equ REG_SQR1CNT,   0x4000068       @ Square wave 1 channel control.
.equ REG_GBCWAVCNT, 0x4000070       @ GBC wave channel control.
.equ REG_NOISECNT,  0x4000078       @ Noise channel control.
.equ REG_SOUNDCNT,  0x4000080       @ Master sound control.
.equ REG_AMPRES,    0x4000088       @ Amplifier resolution control.
.equ REG_WAVE_RAM,  0x4000090       @ GBC wave RAM.
.equ REG_DS_FIFO_A, 0x40000A0       @ Direct sound FIFO A
.equ REG_DS_FIFO_B, 0x40000A4       @ Direct sound FIFO B

.equ REG_DMA1SRC,   0x40000BC       @ DMA1 source address
.equ REG_DMA1DST,   0x40000C0       @ DMA1 destination address
.equ REG_DMA1CNT,   0x40000C4       @ DMA1 control register
.equ REG_DMA2SRC,   0x40000C8       @ DMA2 source address
.equ REG_DMA2DST,   0x40000CC       @ DMA2 destination address
.equ REG_DMA2CNT,   0x40000D0       @ DMA2 control register
.equ REG_DMA3SRC,   0x40000D4	    @ DMA3 source address
.equ REG_DMA3DST,   0x40000D8	    @ DMA3 dest address
.equ REG_DMA3CNT,   0x40000DC	    @ DMA3 control register

.equ REG_TM0DAT,    0x4000100       @ Timer 0 data
.equ REG_TM1DAT,    0x4000104       @ Timer 1 data
.equ REG_TM2DAT,    0x4000108	    @ Timer 2 data
.equ REG_TM3DAT,    0x400010C	    @ Timer 3 data

.equ REG_KEY,	    0x4000130	    @ Controller input register

.equ REG_IE,	    0x4000200	    @ Interrupt enable register
.equ REG_IF,	    0x4000202	    @ Interrupt service flags
.equ REG_IME,	    0x4000208	    @ Master interrupt flag

.equ REG_CART,	    0x4000204	    @ Cartridge/WS control register

.equ palram_base,   0x5000000

.equ vram_base,	    0x6000000

.equ oam_base,	    0x7000000

@ Interrupts
.equ INT_VBLANK,    0
.equ INT_HBLANK,    1
.equ INT_VCOUNT,    2
.equ INT_TIMER0,    3
.equ INT_TIMER1,    4
.equ INT_TIMER2,    5
.equ INT_TIMER3,    6
.equ INT_SERCOM,    7
.equ INT_DMA0,	    8
.equ INT_DMA1,	    9
.equ INT_DMA2,	    10
.equ INT_DMA3,	    11
.equ INT_KEY,	    12
.equ INT_CART,	    13


@ Buttons
.equ KEY_A,	    1
.equ KEY_B,	    2
.equ KEY_SELECT,    4
.equ KEY_START,	    8
.equ KEY_RIGHT,	    16
.equ KEY_LEFT,	    32
.equ KEY_UP,	    64
.equ KEY_DOWN,	    128
.equ KEY_TRIGGER_R, 256
.equ KEY_TRIGGER_L, 512


@ EOF gba.inc  vim: syn=asm
