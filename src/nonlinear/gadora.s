; Always set clipdata for all Gadoras
.org 08042E22h
    b       08042E66h

.org 08042E3Ah
    b       08042E66h

.org 08042E68h ; Editing GadoraInit
.area 4
    bl      GadoraSetCollision
.endarea

.org 08042E96h ; Editing GadoraDeath
.area 4
    bl      GadoraSetCollision
.endarea

.autoregion
.align 2
.func GadoraSetCollision
; Arguments: r0 = ClipData Affecting Action
    push    { r4-r7, lr }
    mov     r4, r0      ; Store ClipData Affecting action
    lsl     r4, #18h
    lsr     r4, #18h

    ; Store Current Sprite Coordinates
    ldr     r0, =CurrentSprite
    ldrh    r7, [r0, #Sprite_YPosition]
    lsr     r7, #06h
    ldrh    r6, [r0, #Sprite_XPosition]
    lsr     r6, #06h

@@check_clipdata_action:
    ;   if MakeSolid
    cmp     r4, #ClipdataAction_MakeSolid
    beq     @@save_door_clipdata
    ;   elseif RemoveSolid
    cmp     r4, #ClipdataAction_RemoveSolid
    beq     @@load_door_clipdata
    ;   else
    b       @@return

@@save_door_clipdata:
; TODO: This can store "closing door" special clipdata if entering from the
; opposite side of a Gadora. Some logic will be needed to determine how we can
; determine the door slot
    ldr     r5, =LevelLayers+LevelLayers_Clipdata
    ldrh    r2, [r5, #LevelLayer_Stride]    ; Room Width
    ldr     r3, [r5, #LevelLayer_Data]      ; Decompressed Clipdata Pointer
    mul     r2, r7
    add     r2, r2, r6                      ; (Room Width * yPosition) + xPositon
    lsl     r2, #01h                        ; offset for hword
    add     r3, r3, r2
    ldrh    r3, [r3]                        ; Clipdata WRAM Location + Current Tile Offset
    strh    r3, [r0, #Sprite_Work3]         ; Store in current sprite work ram
    ldr     r4, =#ClipdataTile_MakeSolid
    b       @@put_door_clipdata

@@load_door_clipdata:
    ldrh    r4, [r0, #Sprite_Work3]

@@put_door_clipdata:
    mov     r0, r4      ; clipdata to write
    mov     r1, r7      ; y pos
    sub     r1, #02     ; Topmost block
    mov     r2, r6      ; x pos
    bl      SetClipdata

    mov     r0, r4
    mov     r1, r7
    sub     r1, #01     ; Top center block
    mov     r2, r6
    bl      SetClipdata

    mov     r0, r4
    mov     r1, r7      ; Bottom center block
    mov     r2, r6
    bl      SetClipdata

    mov     r0, r4
    mov     r1, r7
    add     r1, #01     ; Bottommost block
    mov     r2, r6
    bl      SetClipdata

@@return:
    pop     { r4-r7 }
    pop     { r0 }
    bx      r0
    .pool
.endfunc
.endautoregion
