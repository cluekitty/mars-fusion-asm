; Always set clipdata for all Gadoras
.org 08042E22h
    b       08042E66h

.org 08042E3Ah
    b       08042E66h

.org 08042EB8h
.area 4
    bl      @GadoraInitHighjack
.endarea

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
    ldr     r5, =LevelLayers+LevelLayers_Clipdata
    ldrh    r2, [r5, #LevelLayer_Stride]    ; Room Width
    ldr     r3, [r5, #LevelLayer_Data]      ; Decompressed Clipdata Pointer
    mul     r2, r7
    add     r2, r2, r6                      ; (Room Width * yPosition) + xPositon
    lsl     r2, #01h                        ; offset for hword
    add     r3, r3, r2
    ldrh    r3, [r3]                        ; Clipdata WRAM Location + Current Tile Offset
    lsl     r3, #10h
    asr     r3, #10h
    bmi     @@find_from_special_clipdata
@@store_clipdata:
    strh    r3, [r0, #Sprite_WorkX]         ; Store in current sprite work ram
    ldr     r4, =#ClipdataTile_MakeSolid
    b       @@put_door_clipdata

@@load_door_clipdata:
; TODO: When loading clipdata, if you had entered from the opposite door of the
;   Gadora, there is an opportunity to run back through the door right as the
;   Gadora is defeated. The timing is tight, but generous enough to potentially
;   be done accidentally.
    ldr     r4, =HatchData
    mov     r1, #Sprite_Work3   ; Hatch Number
    ldrb    r3, [r0, r1]
    lsl     r3, #02
    add     r4, r3
    mov     r2, #03
    strb    r2, [r4, #HatchData_Animation]
    mov     r2, #1  ; Enable Hatch
    ldrb    r1, [r4, #HatchData_Status]
    orr     r1, r2
    strb    r1, [r4, #HatchData_Status]
    ldrh    r4, [r0, #Sprite_WorkX]

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
    b       @@return

@@find_from_special_clipdata:
    ldr     r5, =HatchData
    mov     r4, #00
@@loop:
    lsl     r2, r4, #02
    add     r2, r5      ; HatchData + HatchNbr
    ldrb    r1, [r2, #HatchData_XPosition]
    cmp     r1, r6
    bne     @@cont
    ldrb    r1, [r2, #HatchData_YPosition]
    cmp     r1, r7      ; topmost hatch block
    beq     @@found
    add     r1, #01
    cmp     r1, r7      ; top center hatch block
    beq     @@found
    add     r1, #01
    cmp     r1, r7      ; bottom center hatch block
    beq     @@found
    add     r1, #01
    cmp     r1, r7      ; bottommost hatch block
    beq     @@found
@@cont:
    add     r4, #01
    cmp     r4, #HatchData_Count
    bcc     @@loop
    b       @@return    ; no matches found

@@found:
    mov     r3, #Sprite_Work3
    strb    r4, [r0, r3]        ; Hatch Number
    lsl     r3, r4, #02
    add     r3, r5
    mov     r2, #00
    strb    r2, [r3, #HatchData_Animation]
    ldrb    r2, [r3, #HatchData_Status]
    lsr     r2, #01
    lsl     r2, #01
    strb    r2, [r3, #HatchData_Status]
    mov     r3, r2
    lsr     r3, #05     ; Door Type, 0-4, Locked, 4, 4
    mov     r2, #HatchData_Count
    mul     r2, r3
    add     r2, r2, r4
    lsl     r2, #01     ; offset for hword
    ldr     r1, =@GadoraDoorLookupTable
    ldrh    r3, [r1, r2]
    b       @@store_clipdata


@@return:
    pop     { r4-r7 }
    pop     { r0 }
    bx      r0
    .pool
.endfunc

.align 2
@GadoraDoorLookupTable:
    .dh     30h, 31h, 32h, 33h, 34h, 35h    ; lv 0, slots 1-6
    .dh     36h, 37h, 38h, 39h, 3Ah, 3Bh    ; lv 1, ...
    .dh     40h, 41h, 42h, 43h, 44h, 45h    ; lv 2, ...
    .dh     46h, 47h, 48h, 49h, 4Ah, 4Bh    ; lv 3, ...
    .dh     3Ch, 3Dh, 3Eh, 4Ch, 4Dh, 4Eh    ; lv 4, ...
    .dh     3Fh, 3Fh, 3Fh, 3Fh, 3Fh, 3Fh    ; locked
    .dh     3Ch, 3Dh, 3Eh, 4Ch, 4Dh, 4Eh    ; lv 4, ...
    .dh     3Ch, 3Dh, 3Eh, 4Ch, 4Dh, 4Eh    ; lv 4, ...


@GadoraInitHighjack:
    push    { lr }
    bl      TrySetAbsorbXFlag
    ldr     r5, =CurrentSprite
    mov     r0, #00
    strh    r0, [r5, #Sprite_WorkX]
    strh    r0, [r5, #Sprite_Work3]
    pop     { r0 }
    bx      r0
    .pool
.endautoregion
