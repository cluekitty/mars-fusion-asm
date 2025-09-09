; Repointing Vanilla Pause Screen OAM Data so that we can append to the list
; Updating File Select Menu to properly display health over 2099

/*  Pause Screen OAM Changes
    - Re-points OAM data to expand the list.
    - Adds "L0 Lock" information.
    TODO: See if we can force armips to error if null pointers are in this table
    Note: If you are adding more OAM sprites to this table, be sure to do the following:
    1. Update MenuSpriteGfx_Size in enums.inc
    2. Set the pointer for your new gfx to the index of this table such that it overwrites
       the null pointer generated below. Failure to do this may result in a crash.
*/
.autoregion
.align 4
PauseScreenOamData:
; Vanilla OAM Pointers
.incbin "metroid4.gba", VanillaPauseScreenOamData & 7FFFFFh, 230h

.org PauseScreenOamData + (MenuSpriteGfx_SelectMapChange * 4)
    .dw     @SelectMapChangeOamDataPointers

.org PauseScreenOamData + (MenuSpriteGfx_Lv0Locked * 4)
    .dw     @Lv0LockedOamDataPointers

.org PauseScreenOamData + (MenuSpriteGfx_Lv0Unlocked * 4)
    .dw     @Lv0UnlockedOamDataPointers
.endautoregion


; Replace Vanilla references to PauseScreenOamData
.org 08078A5Ch
.area 4
    .dw PauseScreenOamData
.endarea
.org 08078904h
.area 4
    .dw PauseScreenOamData
.endarea
.org 08078890h
.area 4
    .dw PauseScreenOamData
.endarea
.org 0807883Ch
.area 4
    .dw PauseScreenOamData
.endarea
.org 080787E8h
.area 4
    .dw PauseScreenOamData
.endarea
.org 0807876Ch
.area 4
    .dw PauseScreenOamData
.endarea
.org 08078700h
.area 4
    .dw PauseScreenOamData
.endarea
.org 080786ACh
.area 4
    .dw PauseScreenOamData
.endarea


; Add vanilla pause OAM Data to free space
.defineregion 0856F71Ch, 352Dh, 0

.autoregion
.align 4
@PauseScreenObjGfx:
.if !DEBUG
.incbin "data/pause-obj.gfx"
.else
.incbin "data/pause-obj-debug.gfx"
.endif
.endautoregion
.org PauseScreenGfxOamPointer
    .dw @PauseScreenObjGfx


; OAM Data Format
; See: https://problemkaputt.de/gbatek-lcd-obj-oam-attributes.htm for details
; .dh Number of objects
; .dh ObjAttr0
; .dh ObjAttr1
; .dh ObjAttr2
; ... Repeat for as many objects in the frame
; X/Y Coords are offsets of the coordinates set with initial positioning
; Negatives are 2's compliment
; Y Coord is caluclated as (OamYPosition + 4 + InitialPosition)
; X Coord is calculated as
;    ((*pauVar6)[1] & 0xfe00 | InitialPosition + OamXPosition + 4 & 0x1ff)
;    this seems to roughly be (InitialPosition + OamXPosition + 4) & 01FFh, but
;    does not seem to always calculate to this.


;; OAM DATA
; Select to Change Map
.autoregion
    .aligna 2
@SelectMapChangeOamData:
    .dh     4
    ; 2x2 Select Button Graphic
    .dh     (OBJ0_YCoordinate & 007h) | OBJ0_Mode_Normal | OBJ0_Shape_Square
    .dh     (OBJ1_XCoordinate & 007h) | OBJ1_Size_16x16
    .dh     (OBJ2_Character   & 3BEh) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 03h) << OBJ2_Palette)

    .dh     (OBJ0_YCoordinate & 00Bh) | OBJ0_Mode_Normal | OBJ0_Shape_Horizontal
    .dh     (OBJ1_XCoordinate & 010h) | OBJ1_Size_32x8
    .dh     (OBJ2_Character   & 377h) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 03h) << OBJ2_Palette)

    .dh     (OBJ0_YCoordinate & 012h) | OBJ0_Mode_Normal | OBJ0_Shape_Horizontal
    .dh     (OBJ1_XCoordinate & 002h) | OBJ1_Size_32x8
    .dh     (OBJ2_Character   & 3B8h) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 03h) << OBJ2_Palette)

    .dh     (OBJ0_YCoordinate & 012h) | OBJ0_Mode_Normal | OBJ0_Shape_Horizontal
    .dh     (OBJ1_XCoordinate & 022h) | OBJ1_Size_16x8
    .dh     (OBJ2_Character   & 3BCh) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 03h) << OBJ2_Palette)
.endautoregion

; Level 0 Security Locked/Unlocked
.autoregion
@Lv0LockedOamData:
    .dh 3
    ; L0 Sprite
    .dh     (OBJ0_YCoordinate & 0E8h) | OBJ0_Mode_Normal | OBJ0_Shape_Horizontal
    .dh     (OBJ1_XCoordinate & 1E8h) | OBJ1_Size_16x8
    .dh     (OBJ2_Character   & 0C0h) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 08h) << OBJ2_Palette)

    .dh     (OBJ0_YCoordinate & 0E8h) | OBJ0_Mode_Normal | OBJ0_Shape_Square
    .dh     (OBJ1_XCoordinate & 1F8h) | OBJ1_Size_8x8
    .dh     (OBJ2_Character   & 0C2h) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 08h) << OBJ2_Palette)

    ; lock Text
    .dh     (OBJ0_YCoordinate & 0E8h) | OBJ0_Mode_Normal | OBJ0_Shape_Horizontal
    .dh     (OBJ1_XCoordinate & 000h) | OBJ1_Size_16x8
    .dh     (OBJ2_Character   & 1CCh) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 03h) << OBJ2_Palette)

@Lv0UnlockedOamData:
    .dh 3
    ; L0 Sprite
    .dh     (OBJ0_YCoordinate & 0E8h) | OBJ0_Mode_Normal | OBJ0_Shape_Horizontal
    .dh     (OBJ1_XCoordinate & 1E8h) | OBJ1_Size_16x8
    .dh     (OBJ2_Character   & 1B0h) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 08h) << OBJ2_Palette)

    .dh     (OBJ0_YCoordinate & 0E8h) | OBJ0_Mode_Normal | OBJ0_Shape_Square
    .dh     (OBJ1_XCoordinate & 1F8h) | OBJ1_Size_8x8
    .dh     (OBJ2_Character   & 1B2h) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 08h) << OBJ2_Palette)

    ; Open Text
    .dh     (OBJ0_YCoordinate & 0E8h) | OBJ0_Mode_Normal | OBJ0_Shape_Horizontal
    .dh     (OBJ1_XCoordinate & 000h) | OBJ1_Size_16x8
    .dh     (OBJ2_Character   & 1ECh) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 03h) << OBJ2_Palette)
.endautoregion


; OAM Data Pointer Format
; .dw Pointer, Timer (in frames, specify 0FFh for no animation)
; repeat above for each frame
; .dd 0 ; mark end with null DWORD
.autoregion
    .aligna 4
@SelectMapChangeOamDataPointers:
    .dw     @SelectMapChangeOamData
    .dw     0FFh
    .dd     0
@Lv0LockedOamDataPointers:
    .dw     @Lv0LockedOamData
    .dw     0FFh
    .dd     0
@Lv0UnlockedOamDataPointers:
    .dw     @Lv0UnlockedOamData
    .dw     0FFh
    .dd     0
.endautoregion

/* End Pause Screen OAM Changes */
/* File Select Changes
    - Updates drawing code for Energy Tanks on file select
        - will not display more than 20 Energy Tanks
        - If max energy for save file is over 2099, displays a new `+` indicator.
*/

; moves some code and adds additional checks for drawing current energy tanks
.org 080A07A2h
.area 2
    bge     @ReturnFromFileDrawInfoEnergyTankGfxHighjack_1
.endarea

.org  080A07AEh
.area 080A07E2h-., 0
    bl      @FileDrawInfoEnergyTankGfxHighjack_1
@ReturnFromFileDrawInfoEnergyTankGfxHighjack_1:
    mov     r1, r8
    ldr     r0, [r1, #04h]
    cmp     r0, #01
    bne     080A082Ah
    ; if we have already drawn 20 tanks, skip drawing extra
    cmp     r6, #20
.definelabel @@skip, 080A0822h
    bge     @@skip
    cmp     r6, #10
    bne     @ReturnToOriginalCodeFlow_1
    mov     r2, #(GFX_ROW + GFX_TILE*5) >> 4
    lsl     r2, #04
    neg     r2, r2  ; -#4A0h
    add     r7, r7, r2
    b       @ReturnToOriginalCodeFlow_1
.endarea
.definelabel @ReturnToOriginalCodeFlow_1, org()

.org 080A0838h
.area 2
    bge     @ReturnFromFileDrawInfoEnergyTankGfxHighjack_2
.endarea

.org  080A0846h
.area 080A087Ch-., 0
    bl      @FileDrawInfoEnergyTankGfxHighjack_2
@ReturnFromFileDrawInfoEnergyTankGfxHighjack_2:
    mov     r3, r8
    ldr     r0, [r3, #0Ch]
    cmp     r0, #01
.definelabel @@skip, 080A088Ah
    bne     @@skip
    ldr     r0, [r3, #08h]
    cmp     r6, #20
    bge     @@skip
    cmp     r6, r0
    bge     @@skip
    cmp     r6, #10
    bne     @ReturnToOriginalCodeFlow_2
    mov     r0, #(GFX_ROW + GFX_TILE*5) >> 4
    lsl     r0, #04
    neg     r0, r0  ; -#4A0h

    b       @ReturnToOriginalCodeFlow_2
.endarea
.definelabel @ReturnToOriginalCodeFlow_2, org()


.org  080A0A08h
.area 080A0A16h-., 0
    ldr     r0,  =@FileDrawInfoEnergyTankGfxHighjack_3
    mov     pc, r0
    .pool
.endarea

.autoregion
    .align 2
; Draws E-tanks and stops if drawing more than 20
@FileDrawInfoEnergyTankGfxHighjack_1:
@@loop_current:
    ; if loop counter == 10, move e-tank gfx position to top row
    cmp     r6, #10
    bne     @@cont_current
    ldr     r1, =#-(GFX_ROW + GFX_TILE*5)
    add     r7, r7, r1
@@cont_current:
    mov     r0, r12
    str     r0, [r2, #DMA_SAD]
    str     r7, [r2, #DMA_DAD]
    str     r5, [r2, #DMA_CNT]
    ldr     r0, [r2, #DMA_CNT]
    add     r7, #GFX_TILE
    add     r0, r6, #02h
    lsl     r0, r0, #18h
    lsr     r6, r0, #18h
    ldr     r0, [sp, #24h]
    ldr     r1, [r4, #04h]
    sub     r0, r0, r1
    cmp     r6, #20     ; Break out if we have drawn 20 tanks
    bge     @@break
    cmp     r6, r0
    blt     @@loop_current
@@break:
    bx      lr

    .align 2
@FileDrawInfoEnergyTankGfxHighjack_2:
@@loop_max:
    cmp     r6, #10
    bne     @@cont_max
    ldr     r1, =#-(GFX_ROW + GFX_TILE*5)
    add     r7, r7, r1
@@cont_max:
    str     r5, [r2, #DMA_SAD]
    str     r7, [r2, #DMA_DAD]
    str     r4, [r2, #DMA_CNT]
    ldr     r0, [r2, #DMA_CNT]
    add     r7, #GFX_TILE
    add     r0, r6, #02h
    lsl     r0, r0, #18h
    lsr     r6, r0, #18h
    ldr     r0, [r3, #08h]
    ldr     r1, [r3, #0Ch]
    sub     r0, r0, r1
    cmp     r6, #20
    bge     @@break
    cmp     r6, r0
    blt     @@loop_max
@@break:
    bx      lr
    .pool

; This highjack is at the end of the function and includes the return statement.
@FileDrawInfoEnergyTankGfxHighjack_3:
    ; load max energy from current save file
    ldr     r2, =SaveMetadata
    mov     r4, r10         ; r10 contains specified save file
    mov     r0, #SaveMeta_Size
    mul     r0, r4
    add     r0, r2          ; current save file metadata
    ldrh    r0, [r0, #SaveMeta_MaxEnergy]
    ldr     r1, =2099
    sub     r1, r0
    bpl     @@return        ; if 2099 > Max, do nothing

    ldr     r7, =DMA3
    ldr     r3, =@FileSelectOverhealthIndicator
    str     r3, [r7, #DMA_SAD]
    ldr     r6, =VRAM+89A0h ; Tile to the right of the top E-Tank Row for File A
    mov     r0, #(GFX_ROW * 2) >> 4
    lsl     r0, #04
    mul     r0, r4
    add     r6, r0          ; Offset GFX for current file
    str     r6, [r7, #DMA_DAD]
    ldr     r4, =DMA_ENABLE | GFX_TILE/2
    str     r4, [r7, #DMA_CNT]
    ldr     r4, [r7, #DMA_CNT]
    add     r3, #GFX_TILE   ; load the next half of the tile
    str     r3, [r7, #DMA_SAD]
    mov     r4, #GFX_ROW >> 4
    lsl     r4, #04h
    add     r6, r6, r4      ; jump to the next gfx row
    str     r6, [r7, #DMA_DAD]
    ldr     r4, =DMA_ENABLE | GFX_TILE/2
    str     r4, [r7, #DMA_CNT]
    ldr     r4, [r7, #DMA_CNT]

@@return:
    ; Restore vanilla function return statement
    add     sp, #50h
    pop     { r3-r5 }
    mov     r8, r3
    mov     r9, r4
    mov     r10, r5
    pop     { r4-r7 }
    pop     { r0 }
    bx      r0
    .pool
.endautoregion

.autoregion DataFreeSpace, DataFreeSpaceEnd
    .align 4
@FileSelectOverhealthIndicator:
    .incbin "data/file-select-overhealth-indicator.gfx"
.endautoregion
