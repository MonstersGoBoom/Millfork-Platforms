 
* = $0
__start:
; 
;line:71:SegaMasterSystem.mfk
;       asm {
    DI
    LD SP,$DFF0
    LD DE,$FFFC
    LD A,0
    LD (DE),A
    INC DE
    LD (DE),A
    INC DE
    LD A,1
    LD (DE),A
    INC DE
    LD A,2
    LD (DE),A
; 
;line:88:SegaMasterSystem.mfk
;       main()
    JP main
; 
;line
 
* = $66
_nmi:
    EX AF,AF'
    EXX
    ; DISCARD_F
    ; DISCARD_A
    ; DISCARD_HL
    ; DISCARD_BC
    ; DISCARD_DE
    EXX
    EX AF,AF'
    EI
    RETI
 
* = $38
_irq:
    EX AF,AF'
    EXX
    PUSH IX
    PUSH IY
; 
;line:94:SegaMasterSystem.mfk
;       asm {
    IN A,($BF)
; 
;line:97:SegaMasterSystem.mfk
;       framesync = 0
    LD A,0
    LD (framesync),A
; 
;line:66:SegaMasterSystem.mfk
;       ei
    EI
; 
;line:67:SegaMasterSystem.mfk
;       im 1
    IM 1
; 
;line:98:SegaMasterSystem.mfk
;       enable_irq()    
    ; DISCARD_F
    ; DISCARD_A
    ; DISCARD_HL
    ; DISCARD_BC
    ; DISCARD_DE
    POP IY
    POP IX
    EXX
    EX AF,AF'
    EI
    RETI
; 
;line
 
* = $6d
main:
; 
;line:63:SegaMasterSystem.mfk
;       di
    DI
; 
;line:21:main.mfk
;       VREG(VDP_MODE_CTRL_0,VDP_REG0_MODE4)
    LD A,4
    OUT ($BF),A
    LD A,0
    OR $80
    OUT ($BF),A
; 
;line:22:main.mfk
;       VREG(VDP_MODE_CTRL_1,0)
    LD A,0
    OUT ($BF),A
    LD A,1
    OR $80
    OUT ($BF),A
; 
;line:25:main.mfk
;       VREG(VDP_NAMETABLE_BASE,$ff)    
    LD A,$FF
    OUT ($BF),A
    LD A,2
    OR $80
    OUT ($BF),A
; 
;line:26:main.mfk
;       VREG(VDP_COLORTABLE_BASE,$ff)    
    LD A,$FF
    OUT ($BF),A
    LD A,3
    OR $80
    OUT ($BF),A
; 
;line:27:main.mfk
;       VREG(VDP_PATTERN_BASE,$ff)    
    LD A,$FF
    OUT ($BF),A
    LD A,4
    OR $80
    OUT ($BF),A
; 
;line:28:main.mfk
;       VREG(VDP_SATB_BASE,$ff)    
    LD A,$FF
    OUT ($BF),A
    LD A,5
    OR $80
    OUT ($BF),A
; 
;line:29:main.mfk
;       VREG(VDP_SPR_PATTERN_BASE,$ff)    
    LD A,$FF
    OUT ($BF),A
    LD A,6
    OR $80
    OUT ($BF),A
; 
;line:30:main.mfk
;       VREG(VDP_BG_COLOR,$01)    //    bg color    
    LD A,1
    OUT ($BF),A
    LD A,7
    OR $80
    OUT ($BF),A
; 
;line:31:main.mfk
;       VREG(VDP_X_SCROLL,$00) //    xscroll
    LD A,0
    OUT ($BF),A
    LD A,8
    OR $80
    OUT ($BF),A
; 
;line:32:main.mfk
;       VREG(VDP_Y_SCROLL,$00)    //    yscroll 
    LD A,0
    OUT ($BF),A
    LD A,9
    OR $80
    OUT ($BF),A
; 
;line:33:main.mfk
;       VREG(VDP_LINE_COUNTER,$ff)    //    line counter
    LD A,$FF
    OUT ($BF),A
    LD A,$A
    OR $80
    OUT ($BF),A
; 
;line:36:main.mfk
;       VFILL(VDP_STABy,0,256)
    LD HL,$3F00
    LD (VFILL$dest),HL
    LD A,0
    LD (VFILL$value),A
    LD HL,$100
    LD (VFILL$size),HL
; 
;line:160:SegaMasterSystem.mfk
;       VOUT(VDP_CTRL,dest.lo)
    LD A,(VFILL$dest)
    OUT ($BF),A
; 
;line:161:SegaMasterSystem.mfk
;       VOUT(VDP_CTRL,dest.hi)
    LD A,(VFILL$dest + 1)
    OUT ($BF),A
; 
;line:162:SegaMasterSystem.mfk
;       for i,0,paralleluntil,size {
    XOR A
    LD (VFILL$i),A
    LD (VFILL$i + 1),A
    JP .ai__00097.he__00006
.ai__00097.wh__00005:
; 
;line:163:SegaMasterSystem.mfk
;           VOUT(VDP_DATA,value)
    LD A,(VFILL$value)
    OUT ($BE),A
; 
;line:162:SegaMasterSystem.mfk
;       for i,0,paralleluntil,size {
    LD HL,(VFILL$i)
    INC HL
    LD (VFILL$i),HL
.ai__00097.he__00006:
    LD HL,(VFILL$i)
    LD BC,(VFILL$size)
    OR A
    SBC HL,BC
    JP NZ,.ai__00097.wh__00005
; 
;line:39:main.mfk
;       VUPLOAD(VDP_TILE_CLUT,Palette.addr,Palette.length)
    LD HL,$C000
    LD (VUPLOAD$dest),HL
    LD HL,Palette
    LD (VUPLOAD$source),HL
    LD HL,4
    LD (VUPLOAD$size),HL
    CALL VUPLOAD
; 
;line:40:main.mfk
;       VUPLOAD(VDP_SPRITE_CLUT,SprPalette.addr,SprPalette.length)
    LD HL,$C010
    LD (VUPLOAD$dest),HL
    LD HL,SprPalette
    LD (VUPLOAD$source),HL
    LD HL,4
    LD (VUPLOAD$size),HL
    CALL VUPLOAD
; 
;line:41:main.mfk
;       VUPLOAD(VDP_TILES,Tiles.addr,Tiles.length)
    LD HL,$4000
    LD (VUPLOAD$dest),HL
    LD HL,Tiles
    LD (VUPLOAD$source),HL
    LD HL,$40
    LD (VUPLOAD$size),HL
    CALL VUPLOAD
; 
;line:43:main.mfk
;       spriteX0 = 128
    LD A,$80
    LD (main$spriteX0),A
; 
;line:44:main.mfk
;       spriteY0 = 128
    LD (main$spriteY0),A
; 
;line:45:main.mfk
;       spriteX1 = 192
    LD A,$C0
    LD (main$spriteX1),A
; 
;line:46:main.mfk
;       spriteY1 = 128
    LD A,$80
    LD (main$spriteY1),A
; 
;line:49:main.mfk
;       VOUT(VDP_CTRL,$00)
    LD A,0
    OUT ($BF),A
; 
;line:50:main.mfk
;       VOUT(VDP_CTRL,$38 | $40)
    LD A,$78
    OUT ($BF),A
; 
;line:51:main.mfk
;       for i,0,until,Tilemap.length
    LD A,0
    LD (main$i),A
    LD (main$i + 1),A
.do__00058:
; 
;line:53:main.mfk
;           VOUT(VDP_DATA,Tilemap[i])
    LD BC,Tilemap.array
    LD HL,(main$i)
    ADD HL,BC
    LD A,(HL)
    OUT ($BE),A
; 
;line:54:main.mfk
;           VOUT(VDP_DATA,$00)
    LD A,0
    OUT ($BE),A
; 
;line:51:main.mfk
;       for i,0,until,Tilemap.length
    LD HL,(main$i)
    INC HL
    LD (main$i),HL
    LD BC,$300
    OR A
    SBC HL,BC
    JP NZ,.do__00058
; 
;line:58:main.mfk
;       VUPLOAD(VDP_SPRITES,Tiles.addr,Tiles.length)
    LD HL,$6000
    LD (VUPLOAD$dest),HL
    LD HL,Tiles
    LD (VUPLOAD$source),HL
    LD HL,$40
    LD (VUPLOAD$size),HL
    CALL VUPLOAD
; 
;line:60:main.mfk
;       VREG(VDP_MODE_CTRL_1,VDP_REG1_240_MODE | VDP_REG1_EN_DISPLAY | VDP_REG1_EN_FRM_IRQ  )
    LD A,$68
    OUT ($BF),A
    LD A,1
    OR $80
    OUT ($BF),A
; 
;line:66:SegaMasterSystem.mfk
;       ei
    EI
; 
;line:67:SegaMasterSystem.mfk
;       im 1
    IM 1
; 
;line:64:main.mfk
;       while true
.wh__00069:
; 
;line:105:SegaMasterSystem.mfk
;       framesync+=1
    LD HL,framesync
    INC (HL)
; 
;line:106:SegaMasterSystem.mfk
;       while (framesync!=0){}
    JP .ai__00098.he__00027
.ai__00098.wh__00026:
.ai__00098.he__00027:
    LD A,(framesync)
    OR A
    JP NZ,.ai__00098.wh__00026
; 
;line:69:main.mfk
;           VOUT(VDP_CTRL,$00)
    LD A,0
    OUT ($BF),A
; 
;line:70:main.mfk
;           VOUT(VDP_CTRL,$3f)    //    updating sprite Y 
    LD A,$3F
    OUT ($BF),A
; 
;line:72:main.mfk
;           VOUT(VDP_DATA,spriteY0)
    LD A,(main$spriteY0)
    OUT ($BE),A
; 
;line:73:main.mfk
;           VOUT(VDP_DATA,spriteY1)
    LD A,(main$spriteY1)
    OUT ($BE),A
; 
;line:76:main.mfk
;           VOUT(VDP_DATA,208 )
    LD A,$D0
    OUT ($BE),A
; 
;line:77:main.mfk
;           VOUT(VDP_DATA,208 )
    LD A,$D0
    OUT ($BE),A
; 
;line:82:main.mfk
;           VOUT(VDP_CTRL,$80)
    LD A,$80
    OUT ($BF),A
; 
;line:83:main.mfk
;           VOUT(VDP_CTRL,$3f)    //    updating sprite X & ID 
    LD A,$3F
    OUT ($BF),A
; 
;line:85:main.mfk
;           VOUT(VDP_DATA,0)
    LD A,0
    OUT ($BE),A
; 
;line:86:main.mfk
;           VOUT(VDP_DATA,spriteX0)
    LD A,(main$spriteX0)
    OUT ($BE),A
; 
;line:88:main.mfk
;           VOUT(VDP_DATA,0)
    LD A,0
    OUT ($BE),A
; 
;line:89:main.mfk
;           VOUT(VDP_DATA,spriteX1)
    LD A,(main$spriteX1)
    OUT ($BE),A
; 
;line:91:main.mfk
;           read_joy1()
    CALL read_joy1
; 
;line:92:main.mfk
;           spriteX0+=input_dx
    LD A,(input_dx)
    LD HL,main$spriteX0
    ADD A,(HL)
    LD (HL),A
; 
;line:93:main.mfk
;           spriteY0+=input_dy
    LD A,(input_dy)
    LD HL,main$spriteY0
    ADD A,(HL)
    LD (HL),A
; 
;line:95:main.mfk
;           read_joy2()
    CALL read_joy2
; 
;line:96:main.mfk
;           spriteX1+=input_dx
    LD A,(input_dx)
    LD HL,main$spriteX1
    ADD A,(HL)
    LD (HL),A
; 
;line:97:main.mfk
;           spriteY1+=input_dy
    LD A,(input_dy)
    LD HL,main$spriteY1
    ADD A,(HL)
    LD (HL),A
; 
;line:64:main.mfk
;       while true
    JP .wh__00069
; 
;line
 
* = $226
read_joy2:
; 
;line:130:SegaMasterSystem.mfk
;       reset_joy()  
    CALL reset_joy
; 
;line:131:SegaMasterSystem.mfk
;       asm {
    IN A,($DC)
    LD (read_joy2$valuea),A
    IN A,($DD)
    LD E,A
; 
;line:137:SegaMasterSystem.mfk
;       valuea>>=6    //    move port two bits down 
    LD HL,read_joy2$valuea
    LD A,(HL)
    RLCA
    RLCA
    AND 3
    LD (HL),A
; 
;line:138:SegaMasterSystem.mfk
;       valuea|=valueb<<2
    LD A,E
    ADD A,A
    ADD A,A
    OR (HL)
    LD (HL),A
; 
;line:139:SegaMasterSystem.mfk
;       if valuea & 1 == 0 { input_dy -= 1 }
    AND 1
    JR NZ,.fi__00021
    LD HL,input_dy
    DEC (HL)
.fi__00021:
; 
;line:140:SegaMasterSystem.mfk
;       if valuea & 2 == 0 { input_dy +=    1 }
    LD A,(read_joy2$valuea)
    AND 2
    JR NZ,.fi__00022
    LD HL,input_dy
    INC (HL)
.fi__00022:
; 
;line:141:SegaMasterSystem.mfk
;       if valuea & 4 == 0 { input_dx -= 1 }
    LD A,(read_joy2$valuea)
    AND 4
    JR NZ,.fi__00023
    LD HL,input_dx
    DEC (HL)
.fi__00023:
; 
;line:142:SegaMasterSystem.mfk
;       if valuea & 8 == 0 { input_dx += 1 }
    LD A,(read_joy2$valuea)
    AND 8
    JR NZ,.fi__00024
    LD HL,input_dx
    INC (HL)
.fi__00024:
; 
;line:143:SegaMasterSystem.mfk
;       if valuea & 16 == 0 { input_a = 1 }
    LD A,(read_joy2$valuea)
    AND $10
; 
;line
    RET NZ
; 
;line:143:SegaMasterSystem.mfk
;       if valuea & 16 == 0 { input_a = 1 }
    LD A,1
    LD (input_btn),A
.fi__00025:
    ; DISCARD_F
    ; DISCARD_A
    ; DISCARD_HL
    ; DISCARD_BC
    ; DISCARD_DE
    RET
; 
;line
 
* = $274
VUPLOAD:
; 
;line:148:SegaMasterSystem.mfk
;       asm {
    IN A,($BF)
; 
;line:151:SegaMasterSystem.mfk
;       VOUT(VDP_CTRL,dest.lo)
    LD A,(VUPLOAD$dest)
    OUT ($BF),A
; 
;line:152:SegaMasterSystem.mfk
;       VOUT(VDP_CTRL,dest.hi)
    LD A,(VUPLOAD$dest + 1)
    OUT ($BF),A
; 
;line:153:SegaMasterSystem.mfk
;       for i,0,until,size {        
    XOR A
    LD (VUPLOAD$i),A
    LD (VUPLOAD$i + 1),A
    JP .he__00016
.wh__00015:
; 
;line:154:SegaMasterSystem.mfk
;           VOUT(VDP_DATA,source[i])
    LD BC,(VUPLOAD$i)
    LD HL,(VUPLOAD$source)
    ADD HL,BC
    LD A,(HL)
    OUT ($BE),A
; 
;line:153:SegaMasterSystem.mfk
;       for i,0,until,size {        
    LD HL,(VUPLOAD$i)
    INC HL
    LD (VUPLOAD$i),HL
.he__00016:
    LD HL,(VUPLOAD$i)
    LD BC,(VUPLOAD$size)
    OR A
    SBC HL,BC
    JP NZ,.wh__00015
    ; DISCARD_F
    ; DISCARD_A
    ; DISCARD_HL
    ; DISCARD_BC
    ; DISCARD_DE
    RET
; 
;line
 
* = $2aa
read_joy1:
; 
;line:116:SegaMasterSystem.mfk
;       reset_joy()  
    CALL reset_joy
; 
;line:117:SegaMasterSystem.mfk
;       asm {
    IN A,($DC)
    LD E,A
; 
;line:121:SegaMasterSystem.mfk
;       if value & 1 == 0 { input_dy -= 1 }
    AND 1
    JR NZ,.fi__00099
    LD HL,input_dy
    DEC (HL)
.fi__00099:
; 
;line:122:SegaMasterSystem.mfk
;       if value & 2 == 0 { input_dy +=    1 }
    LD A,E
    AND 2
    JR NZ,.fi__00100
    LD HL,input_dy
    INC (HL)
.fi__00100:
; 
;line:123:SegaMasterSystem.mfk
;       if value & 4 == 0 { input_dx -= 1 }
    LD A,E
    AND 4
    JR NZ,.fi__00101
    LD HL,input_dx
    DEC (HL)
.fi__00101:
; 
;line:124:SegaMasterSystem.mfk
;       if value & 8 == 0 { input_dx += 1 }
    LD A,E
    AND 8
    JR NZ,.fi__00102
    LD HL,input_dx
    INC (HL)
.fi__00102:
; 
;line:125:SegaMasterSystem.mfk
;       if value & 16 == 0 { input_a = 1 }
    LD A,E
    AND $10
; 
;line
    RET NZ
; 
;line:125:SegaMasterSystem.mfk
;       if value & 16 == 0 { input_a = 1 }
    LD A,1
    LD (input_btn),A
.fi__00103:
    ; DISCARD_F
    ; DISCARD_A
    ; DISCARD_HL
    ; DISCARD_BC
    ; DISCARD_DE
    RET
; 
;line
 
* = $17
reset_joy:
; 
;line:13:joy.mfk
;       input_dx = 0
    XOR A
    LD (input_dx),A
; 
;line:14:joy.mfk
;       input_dy = 0
    LD (input_dy),A
; 
;line:15:joy.mfk
;       input_btn = 0
    LD (input_btn),A
    ; DISCARD_F
    ; DISCARD_A
    ; DISCARD_HL
    ; DISCARD_BC
    ; DISCARD_DE
    RET
; 
;line
* = $22
Palette.array:
    DB 1, $3F, $2A, $12
* = $2dd
Tilemap.array:
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    DB 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    DB 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    DB 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0
    DB 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
    DB 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0
    DB 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1
    DB 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1
    DB 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1
    DB 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0
    DB 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0
    DB 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0
    DB 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    DB 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1
    DB 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0
    DB 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
    DB 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0
    DB 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1
    DB 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    DB 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    DB 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    DB 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    DB 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    DB 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0
    DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0
    DB 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0
* = $5dd
Tiles.array:
    DB $FF, $FF, 0, 0, $81, $FF, 0, 0, $BD, $FF, 0, 0, $BD, $E7, 0, 0
    DB $BD, $E7, 0, 0, $BD, $FF, 0, 0, $81, $FF, 0, 0, $FF, $FF, 0, 0
    DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
* = $26
SprPalette.array:
    DB 1, $3F, $2A, $14
.ai__00097.he__00006           = $010D
.ai__00097.wh__00005           = $0101
.ai__00098.he__00027           = $01C2
.ai__00098.wh__00026           = $01C2
.do__00058                     = $017B
.fi__00021                     = $0247
.fi__00022                     = $0252
.fi__00023                     = $025D
.fi__00024                     = $0268
.fi__00025                     = $0273
.fi__00099                     = $02B8
.fi__00100                     = $02C1
.fi__00101                     = $02CA
.fi__00102                     = $02D3
.fi__00103                     = $02DC
.he__00016                     = $029C
.wh__00015                     = $028A
.wh__00069                     = $01BB
Palette.array                  = $0022
SprPalette.array               = $0026
Tilemap.array                  = $02DD
Tiles.array                    = $05DD
VFILL$dest                     = $C005
VFILL$i                        = $C003
VFILL$size                     = $C000
VFILL$value                    = $C002
VUPLOAD                        = $0274
VUPLOAD$dest                   = $C005
VUPLOAD$i                      = $C003
VUPLOAD$size                   = $C000
VUPLOAD$source                 = $C008
__heap_start                   = $C013
__rwdata_end                   = $0000
__rwdata_start                 = $0000
__start                        = $0000
__zeropage_end                 = $0100
__zeropage_first               = $0000
__zeropage_last                = $00FF
__zeropage_usage               = $0100
_irq                           = $0038
_nmi                           = $0066
framesync                      = $C00A
input_btn                      = $C007
input_dx                       = $C012
input_dy                       = $C011
main                           = $006D
main$i                         = $C00E
main$spriteX0                  = $C00D
main$spriteX1                  = $C00C
main$spriteY0                  = $C00B
main$spriteY1                  = $C010
read_joy1                      = $02AA
read_joy2                      = $0226
read_joy2$valuea               = $C002
reset_joy                      = $0017
segment.default.bank           = $0000
segment.default.end            = $DFFF
segment.default.heapstart      = $C013
segment.default.length         = $2000
segment.default.start          = $C000
    ; $0000 = __rwdata_end
    ; $0000 = __rwdata_start
    ; $0000 = __start
    ; $0000 = __zeropage_first
    ; $0000 = segment.default.bank
    ; $0017 = reset_joy
    ; $0022 = Palette.array
    ; $0026 = SprPalette.array
    ; $0038 = _irq
    ; $0066 = _nmi
    ; $006D = main
    ; $00FF = __zeropage_last
    ; $0100 = __zeropage_end
    ; $0100 = __zeropage_usage
    ; $0101 = .ai__00097.wh__00005
    ; $010D = .ai__00097.he__00006
    ; $017B = .do__00058
    ; $01BB = .wh__00069
    ; $01C2 = .ai__00098.he__00027
    ; $01C2 = .ai__00098.wh__00026
    ; $0226 = read_joy2
    ; $0247 = .fi__00021
    ; $0252 = .fi__00022
    ; $025D = .fi__00023
    ; $0268 = .fi__00024
    ; $0273 = .fi__00025
    ; $0274 = VUPLOAD
    ; $028A = .wh__00015
    ; $029C = .he__00016
    ; $02AA = read_joy1
    ; $02B8 = .fi__00099
    ; $02C1 = .fi__00100
    ; $02CA = .fi__00101
    ; $02D3 = .fi__00102
    ; $02DC = .fi__00103
    ; $02DD = Tilemap.array
    ; $05DD = Tiles.array
    ; $2000 = segment.default.length
    ; $C000 = VFILL$size
    ; $C000 = VUPLOAD$size
    ; $C000 = segment.default.start
    ; $C002 = VFILL$value
    ; $C002 = read_joy2$valuea
    ; $C003 = VFILL$i
    ; $C003 = VUPLOAD$i
    ; $C005 = VFILL$dest
    ; $C005 = VUPLOAD$dest
    ; $C007 = input_btn
    ; $C008 = VUPLOAD$source
    ; $C00A = framesync
    ; $C00B = main$spriteY0
    ; $C00C = main$spriteX1
    ; $C00D = main$spriteX0
    ; $C00E = main$i
    ; $C010 = main$spriteY1
    ; $C011 = input_dy
    ; $C012 = input_dx
    ; $C013 = __heap_start
    ; $C013 = segment.default.heapstart
    ; $DFFF = segment.default.end