@ Hefts lookup table.
@
@ $Id: hefts.s,v 1.1 2002/12/09 13:09:29 tek Exp $


        .global heft_linear_xlat
heft_linear_xlat:
.hword 0x3, 0x3, 0x3, 0x3, 0x3, 0x3, 0x3, 0x3, 0x4, 0x4, 0x4, 0x4, 0x4, 0x4
.hword 0x5, 0x5, 0x5, 0x5, 0x6, 0x6, 0x6, 0x6, 0x7, 0x7, 0x7, 0x7, 0x8, 0x8
.hword 0x8, 0x9, 0x9, 0xa, 0xa, 0xa, 0xb, 0xb, 0xc, 0xc, 0xd, 0xd, 0xe, 0xe
.hword 0xf, 0x10, 0x10, 0x11, 0x12, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x17
.hword 0x18, 0x19, 0x1a, 0x1c, 0x1d, 0x1e, 0x1f, 0x20, 0x22, 0x23, 0x24, 0x26
.hword 0x27, 0x29, 0x2b, 0x2c, 0x2e, 0x30, 0x32, 0x34, 0x36, 0x38, 0x3b, 0x3d
.hword 0x3f, 0x42, 0x45, 0x47, 0x4a, 0x4d, 0x50, 0x54, 0x57, 0x5a, 0x5e, 0x62
.hword 0x66, 0x6a, 0x6e, 0x73, 0x77, 0x7c, 0x81, 0x86, 0x8c, 0x91, 0x97, 0x9d
.hword 0xa3, 0xaa, 0xb1, 0xb8, 0xbf, 0xc7, 0xcf, 0xd7, 0xe0, 0xe9, 0xf2, 0xfc
.hword 0x106, 0x110, 0x11b, 0x127, 0x132, 0x13f, 0x14b, 0x159, 0x167, 0x175
.hword 0x184, 0x193, 0x1a4, 0x1b4, 0x1c6, 0x1d8, 0x1eb, 0x1ff, 0x213, 0x228
.hword 0x23e, 0x255, 0x26d, 0x286, 0x2a0, 0x2bb, 0x2d7, 0x2f4, 0x312, 0x332
.hword 0x352, 0x375, 0x398, 0x3bd, 0x3e3, 0x40b, 0x434, 0x45f, 0x48c, 0x4bb
.hword 0x4eb, 0x51e, 0x552, 0x588, 0x5c1, 0x5fc, 0x639, 0x679, 0x6bb, 0x700
.hword 0x748, 0x793, 0x7e0, 0x831, 0x885, 0x8dc, 0x937, 0x995, 0x9f7, 0xa5d
.hword 0xac8, 0xb36, 0xba9, 0xc20, 0xc9c, 0xd1e, 0xda4, 0xe30, 0xec1, 0xf58
.hword 0xff5, 0x1099, 0x1142, 0x11f3, 0x12ab, 0x136a, 0x1431, 0x1500, 0x15d7
.hword 0x16b7, 0x179f, 0x1891, 0x198d, 0x1a92, 0x1ba2, 0x1cbd, 0x1de4, 0x1f16
.hword 0x2054, 0x219f, 0x22f8, 0x245e, 0x25d2, 0x2755, 0x28e8, 0x2a8b, 0x2c3f
.hword 0x2e04, 0x2fdb, 0x31c5, 0x33c3, 0x35d5, 0x37fc, 0x3a39, 0x3c8e, 0x3efa
.hword 0x417f, 0x441d, 0x46d7, 0x49ac, 0x4c9f, 0x4faf, 0x52df, 0x5630, 0x59a2
.hword 0x5d38, 0x60f3, 0x64d4, 0x68dc, 0x6d0e, 0x716b, 0x75f4, 0x7aac, 0x7f94
.hword 0x84ae, 0x89fd, 0x8f82, 0x9540, 0x9b38, 0xa16d, 0xa7e2, 0xae9a, 0xb596
.hword 0xbcd9, 0xc467, 0xcc42, 0xd46e, 0xdced, 0xe5c3, 0xeef4, 0xf883, 0xffff

@ EOF hefts.s
