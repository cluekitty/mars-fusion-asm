.org RemoveNeverReformBlocksAndCollectedTanks
.area 08064AEBh-08064ADCh, 0
    push    { lr }
    bl       @RemoveMiscTilesFromRoom
    pop     { r0 }
    bx      r0
.endarea

.org RevealHiddenTilesFlagPointer
.area 04h
    .dw     RevealHiddenTilesFlag
.endarea

.org 0806B962h ; Editing UpdateBlockAnimation, case 07h
.area 0806B968h-0806B962h, 0
    bl      @BreakStateIfRevealed
.endarea

.autoregion
RevealHiddenTilesFlag:
    .db     01h
    .align 2
.func @RemoveMiscTilesFromRoom
    push    { lr }
    bl      RemoveNeverReformBlocks
    bl      RemoveCollectedTanks
    bl      RevealHiddenBreakableTiles
    pop     { r0 }
    bx      r0
.endfunc


.func @BreakStateIfRevealed
    push    { r4, lr }
    ldr     r4, =RevealHiddenTilesFlag
    ldrb    r4, [r4]
    cmp     r4, 0
    bne     @@if_revealed
@@if_vanilla:
    add     r0, #01h
    b       @@return
@@if_revealed:
    ldr     r4, [sp]
    bl      RevealBombChainTile
    cmp     r4, #1
    beq     @@if_vanilla
    sub     r0, #05h
@@return:
    lsl     r0, r0, #10h
    lsr     r5, r0, #10h
    pop     { r4, lr }
    .pool
.endfunc


.func RevealBombChainTile
; input
; r4 = stack pointer, should have indexed block being checked for updating animation
; output
; r4 = bool
;      true = block found and r0 updated
;      false = no block found
    push    { r5-r7, lr }
    mov     r6, r4
    mov     r5, #0
    ldrb    r3, [r6, BrokenBlock_YPos]
    ldrb    r2, [r6, BrokenBlock_XPos]
    ldr     r7, =StoredRevealedTiles
@@loop:
    lsl     r4, r5, #2      ; index = counter * 4
    add     r4, r4, r7      ; StoredRevealedTiles + index
    ldrb    r1, [r4, StoredRevealedTiles_XPos]
    cmp     r1, r2
    bne     @@inc_counter
    ldrb    r1, [r4, StoredRevealedTiles_YPos]
    cmp     r1, r3
    bne     @@inc_counter
    ldrh    r0, [r4, StoredRevealedTiles_Type]
    b       @@return_true
@@inc_counter:
    add     r5, #1
    cmp     r5, #StoredRevealedTiles_Len
    blt     @@loop
    b       @@return_false
@@return_true:
    mov     r4, 1
    pop     { r5-r7, pc }
@@return_false:
    mov     r4, 0
    pop     { r5-r7, pc }
    .pool
.endfunc


.func RevealHiddenBreakableTiles
    push    { r4-r7, lr }
    mov     r4, r8
    mov     r5, r9
    mov     r6, r10
    push    { r4-r5 }
    sub     sp, #04
    ldr     r0, =RevealHiddenTilesFlag
    ldrb    r0, [r0]
    cmp     r0, #0
    beq     @@return
    ldr     r0, =NonGameplayFlag
    ldrb    r0, [r0]
    cmp     r0, #0
    bne     @@return ; exit early if called from non-gameplay or cutscene
@@clear_StoredRevealedTiles:
    mov     r0, #20h
    str     r0, [sp]
    mov     r0, #3
    mov     r1, #0
    ldr     r2, =StoredRevealedTiles
    ldr     r3, =StoredRevealedTiles_Len * StoredRevealedTiles_Size
    bl      BitFill
@@load_room_info:
    ldr     r7, =LevelLayers + LevelLayers_Clipdata
    ldrh    r6, [r7, LevelLayer_Rows]   ; height
    ldrh    r5, [r7, LevelLayer_Stride] ; width
    ldr     r7, [r7]
    mov     r2, r5
    mul     r2, r6
    add     r2, r2, r5
    lsl     r2, #01
    mov     r10, r2                     ; end of room
    mov     r8, r5                      ; width [sp]
    mov     r9, r6                      ; height [sp+4]
@@loop:
    mov     r1, r7
    mov     r3, r8
    mov     r2, r6
    mov     r2, r10                     ; start at end of room and walk backards
    add     r0, r1, r2
    cmp     r2, #0                      ; stop when we hit the last tile
    beq     @@return
    ldrh    r0, [r7, r2]
    cmp     r0, #ClipdataTile_2x2TopLeftNeverReform
    bls     @@dec_width                 ; if tile is not breakable, skip
    mov     r1, r5
    mov     r2, r6
    bl      @LoadRevealedTile
    mov     r1, #0
    mvn     r1, r1
    lsl     r1, #10h
    lsr     r1, #10h
    cmp     r1, r0  ; if not FFFF
    bne     @@reveal_hidden_block
    b       @@dec_width
@@reveal_hidden_block:
    ; r0 should contain value of new tile
    mov     r1, r6  ; Y Pos
    mov     r2, r5  ; X Pos
    bl      SetSpecialBg1Tile
@@dec_width:
    mov     r2, r10 ;\
    sub     r2, #02 ;} Decrement Room Tile Index
    mov     r10, r2 ;/
    sub     r5, #01
    cmp     r5, #00
    bgt     @@loop
@@dec_height:
    sub     r6, #01
    cmp     r6, #00
    beq     @@return
    mov     r5, r8
    b       @@loop
@@return:
    add     sp, #4
    pop     { r4-r5 }
    mov     r8, r4
    mov     r9, r5
    mov     r10, r6
    pop     { r4-r7 }
    pop     { r0 }
    bx      r0
    .pool
.endfunc

.func @LoadRevealedTile
; input
; r0 = Block to Search For
; r1 = X Pos
; r2 = Y Pos
; output
; r0 = Replacement Tile, or None (0FFFFh)
    push    { r4-r6, lr }
    ldr     r4, =@ClipDataReplacements
    mov     r5, r1
    mov     r6, r2

    ;Make ClipdataTile_2x2TopLeftNeverReform the starting index at 0
    sub     r0, #ClipdataTile_2x2TopLeftNeverReform
    bmi     @@return_none
    cmp     r0, #ClipdataTile_HorizontalBombChain4 - ClipdataTile_2x2TopLeftNeverReform
    bhi     @@return_none
    lsl     r0, #02
    add     r4, r0
    ldrh    r2, [r4]        ; load tile into r2
    ldrh    r4, [r4, #02]   ; load replacement into r0
    ldr     r1, =ClipdataRevealed_Bomb
    cmp     r4, r1
    bne     @@return_replacement

@@check_bomb_chain:
    mov     r1, #ClipdataTile_VerticalBombChain1
    lsl     r1, r1, 10h
    lsr     r1, r1, 10h
    cmp     r2, r1
    blt     @@return_replacement ; else
    mov     r1, #ClipdataTile_HorizontalBombChain4
    lsl     r1, r1, 10h
    lsr     r1, r1, 10h
    cmp     r1, r2
    blt     @@return_replacement ; else

    mov     r0, r5 ; X Pos
    mov     r1, r6 ; Y Pos
    bl      StoreBombChainTile
    b       @@return_replacement
@@return_none:
    mov     r0, #00
    mvn     r0, r0
    lsl     r0, r0, #10h
    lsr     r0, r0, #10h
@@return_replacement:
    mov     r0, r4
    pop     { r4-r6, pc }
    .pool
.endfunc


.func StoreBombChainTile
; input
; r0 = X Pos
; r1 = Y Pos
    push    { r3-r4, lr }
    sub     sp, #4
    mov     r3, #0
    str     r3, [sp] ; counter @ SP

@@loop:
    ldr     r4, =StoredRevealedTiles
    mov     r3, sp
    ldr     r3, [r3]
    lsl     r3, #2
    add     r4, r4, r3
    ldrh    r3, [r4, StoredRevealedTiles_Type]
    cmp     r3, #0
    bne     @@inc_counter
@@store:
    strb    r0, [r4, StoredRevealedTiles_XPos]
    strb    r1, [r4, StoredRevealedTiles_YPos]
    ldr     r3, =LevelLayers + LevelLayers_Bg1
    ldrh    r2, [r3, LevelLayer_Stride]
    mul     r2, r1      ; height * room width
    add     r2, r2, r0  ; + width
    lsl     r0, r2, #1h
    ldr     r1, [r3]
    ldrh    r1, [r1, r0]
    strh    r1, [r4, StoredRevealedTiles_Type]
    b       @@return
@@inc_counter:
    ldr     r3, [sp]
    add     r3, r3, #1
    str     r3, [sp]
    cmp     r3, #StoredRevealedTiles_Len    ; exit early if end of table
    beq     @@return
    b       @@loop
@@return:
    add     sp, #4
    pop     { r3-r4, pc }
    .pool
.endfunc
.endautoregion

.autoregion
    .align 2
@ClipDataReplacements:
   ;.db Clip to check, replacement clip
    .dh ClipdataTile_2x2TopLeftNeverReform,     ClipdataRevealed_Weak
    .dh ClipdataTile_2x2TopRightNeverReform,    ClipdataRevealed_Weak
    .dh ClipdataTile_WeakNeverReform,           ClipdataRevealed_Weak
    .dh ClipdataTile_WeakReform,                ClipdataRevealed_Weak
    .dh ClipdataTile_MissileNeverReform,        ClipdataRevealed_Missile
    .dh ClipdataTile_BombNeverReform,           ClipdataRevealed_Bomb
    .dh ClipdataTile_BombReform,                ClipdataRevealed_Bomb
    .dh ClipdataTile_PBomb,                     ClipdataRevealed_PBomb
    .dh ClipdataTile_SpeedNoReform,             ClipdataRevealed_Speed
    .dh ClipdataTile_ScrewAttack,               ClipdataRevealed_ScrewAttack
    .dh ClipdataTile_Crumble,                   ClipdataRevealed_Crumble
    .dh ClipdataTile_WeakNoReform,              ClipdataRevealed_Weak
    .dh ClipdataTile_2x2TopLeftNoReform,        ClipdataRevealed_Weak
    .dh ClipdataTile_2x2TopRightNoReform,       ClipdataRevealed_Weak
    .dh ClipdataTile_MissileNoReform,           ClipdataRevealed_Missile
    .dh 005Fh,                                  ClipdataRevealed_None
    .dh ClipdataTile_2x2BottomLeftNeverReform,  ClipdataRevealed_Weak
    .dh ClipdataTile_2x2BottomRightNeverReform, ClipdataRevealed_Weak
    .dh 0062h,                                  ClipdataRevealed_None
    .dh 0063h,                                  ClipdataRevealed_None
    .dh ClipdataTile_MissileTankHidden,         ClipdataRevealed_Pickup
    .dh ClipdataTile_EnergyTankHidden,          ClipdataRevealed_Pickup
    .dh 0066h,                                  ClipdataRevealed_None
    .dh 0067h,                                  ClipdataRevealed_None
    .dh 0068h,                                  ClipdataRevealed_None
    .dh ClipdataTile_PBombTankHidden,           ClipdataRevealed_Pickup
    .dh 006Ah,                                  ClipdataRevealed_None
    .dh ClipdataTile_SpeedReform,               ClipdataRevealed_Speed
    .dh ClipdataTile_2x2BottomLeftNoReform,     ClipdataRevealed_Weak
    .dh ClipdataTile_2x2BottomRightNoReform,    ClipdataRevealed_Weak
    .dh 006Eh,                                  ClipdataRevealed_None
    .dh 006Fh,                                  ClipdataRevealed_None
    .dh ClipdataTile_VerticalBombChain1,        ClipdataRevealed_Bomb
    .dh ClipdataTile_VerticalBombChain2,        ClipdataRevealed_Bomb
    .dh ClipdataTile_VerticalBombChain3,        ClipdataRevealed_Bomb
    .dh ClipdataTile_VerticalBombChain4,        ClipdataRevealed_Bomb
    .dh ClipdataTile_HorizontalBombChain1,      ClipdataRevealed_Bomb
    .dh ClipdataTile_HorizontalBombChain2,      ClipdataRevealed_Bomb
    .dh ClipdataTile_HorizontalBombChain3,      ClipdataRevealed_Bomb
    .dh ClipdataTile_HorizontalBombChain4,      ClipdataRevealed_Bomb

    ; Fill remainder of table to prevent out-of-bounds reads
    .fill (0FFh - ClipdataTile_HorizontalBombChain4) * 4, 0FFh
.endautoregion
