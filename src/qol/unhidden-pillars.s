; 0837AB8Ch ; horizontal gfx
; 0837A984h ; vertical gfx



.org 0837A984h
.area 8
@VerticalVanillaPillarOamPointer:
    .skip 8
.endarea
.org 0837AB8Ch
.area 8
@HorizontalVanillaPillarOamPointer:
    .skip 8
.endarea

.autoregion
    .aligna 4
@VerticalRevealedPillarOamPointer:
    .dw     @VerticalRevealedPillarOamData
    .dw     0FFh
    .dd     0
@HorizontalRevealedPillarOamPointer:
    .dw     @HorizontalRevealedPillarOamData
    .dw     0FFh
    .dd     0
.endautoregion

; OAM Data Pointer Format
; .dw Pointer, Timer (in frames, specify 0FFh for no animation)
; repeat above for each frame
; .dd 0 ; mark end with null DWORD


.autoregion
  .aligna 4
@VerticalRevealedPillarOamData:
    .dh     001h
    .dh     (OBJ0_YCoordinate & 0F0h) | OBJ0_Mode_Normal | OBJ0_Shape_Square
    .dh     (OBJ1_XCoordinate & 1F8h) | OBJ1_Size_16x16
    .dh     (OBJ2_Character   & 21Ah) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 08h) << OBJ2_Palette)
    ;.incbin "metroid4.gba", (readptr(0837A984h) + 2) & 7FFFFFh, 06h

@HorizontalRevealedPillarOamData:
    .dh     001h
    .dh     (OBJ0_YCoordinate & 0F8h) | OBJ0_Mode_Normal | OBJ0_Shape_Square
    .dh     (OBJ1_XCoordinate & 000h) | OBJ1_Size_16x16
    .dh     (OBJ2_Character   & 21Ch) | OBJ2_Priority_Highest | ((OBJ2_PaletteMask & 08h) << OBJ2_Palette)
    ;.incbin "metroid4.gba", (readptr(0837AB8Ch) + 2) & 7FFFFFh, 06h
.endautoregion


.org 08379AF8h
.incbin "data/pillar.gfx"

.org 0804AD8Ah
.area 4
    bl      PillarInit
.endarea


; Rewrites the vanilla function and stores additional information for
.org 0804AA48h
.area 118h, 0
    .align  2
.func PillarInit
    push    { r4-r6, lr }
    ldr     r6, =CurrentSprite
    mov     r5, #0
    ldr     r4, =RevealHiddenTilesFlag
    ldrb    r4, [r4]
    mov     r0, #Sprite_SpritesetSlotAndProperties
    add     r1, r0, r6
    ldrb    r1, [r1]
    cmp     r1, 12h
    beq     @@horizontal
    cmp     r1, 12h
    bgt     @@check_flipped
    cmp     r1, 11h
    beq     @@vertical

@@check_flipped:
    cmp     r1, 13h
    beq     @@horizontal_flipped
    b       @@no_match

@@vertical: ; slot/prop = 11h
    strh    r5, [r6, #Sprite_BboxBottom] ; Sprite_BboxBottom = 0
    mov     r1, #40h
    mov     r2, #Sprite_DrawDistanceTop
    add     r2, r2, r6
    strb    r1, [r2] ; Sprite_DrawDistanceTop = 040h
    strb    r5, [r2, #Sprite_DrawDistanceBottom - Sprite_DrawDistanceTop] ; Sprite_DrawDistanceBottom = 0
    mov     r1, #8
    strb    r1, [r2, #Sprite_DrawDistanceHorizontal - Sprite_DrawDistanceTop] ; Sprite_DrawDistanceHorizontal = 008h
    strb    r5, [r2, #Sprite_Work0 - Sprite_DrawDistanceTop] ; Sprite_Work0 = 0
    sub     r1, #1
    lsl     r1, #2
    strh    r1, [r6, #Sprite_BboxRight] ; Sprite_BboxRight = 01Ch
    neg     r1, r1
    lsl     r1, #10h
    lsr     r1, #10h
    strh    r1, [r6, #Sprite_BboxLeft] ; Sprite_BboxLeft = -01Ch
    sub     r1, #20h
    strh    r1, [r6, #Sprite_BboxTop] ; Sprite_BboxTop = -03Ch

; Sprite_OamPointer = VerticalVanilla or VerticalRevealed
    cmp     r4, #1
    bne     @@load_vanilla_vertical_pillar_oam
@@load_revealed_vertical_pillar_oam:
    mov     r1, #SpriteStatus_IgnoreProjectiles >> 8
    lsl     r1, 8
    ldr     r3, =@VerticalRevealedPillarOamPointer
    mov     r0, #1
    mov     r2, #Sprite_BgPriority
    add     r2, r2, r6
    strb    r0, [r2]
    b       @@cont_vertical
@@load_vanilla_vertical_pillar_oam:
    ldr     r1, =SpriteStatus_NotDrawn|SpriteStatus_IgnoreProjectiles
    ldr     r3, =@VerticalVanillaPillarOamPointer
@@cont_vertical:
    ldr     r0, [r6]
    orr     r1, r0
    strh    r1, [r6, #Sprite_Status] ; Sprite_Status = Sprite_Status | (r1)
    b       @@all_common


@@horizontal_flipped: ; slot/prop = 13h
    strh    r5, [r6, #Sprite_BboxLeft] ; Sprite_BboxLeft = 0
    mov     r1, #40h
    strh    r1, [r6, #Sprite_BboxRight] ; Sprite_BboxRight = 040Ch
    ldrh    r0, [r6, #Sprite_XPosition]
    sub     r0, #20h
    strh    r0, [r6, #Sprite_XPosition] ; Sprite_xPosition = Sprite_xPosition - 020h
    b       @@horizontal_common

@@horizontal: ; slot/prop = 12h
    mov     r1, #40h
    neg     r1, r1
    lsl     r1, #10h
    lsr     r1, #10h
    strh    r1, [r6, #Sprite_BboxLeft] ; Sprite_BboxLeft = -040h
    strh    r5, [r6, #Sprite_BboxRight] ; Sprite_BboxRight = 0
    ldrh    r0, [r6, #Sprite_XPosition]
    add     r0, #20h
    strh    r0, [r6, #Sprite_XPosition] ; Sprite_XPosition = Sprite_XPosition + 020h
    mov     r1, #SpriteStatus_XFlip
    ldrh    r0, [r6, #Sprite_Status]
    orr     r1, r0
    strh    r1, [r6, #Sprite_Status] ; Sprite_Status = Sprite_Status | XFlip

@@horizontal_common:
    mov     r1, #8
    mov     r2, #Sprite_DrawDistanceTop
    add     r2, r2, r6
    strb    r1, [r2, #Sprite_DrawDistanceTop - Sprite_DrawDistanceTop] ; Sprite_DrawDistanceTop = 008h
    strb    r1, [r2, #Sprite_DrawDistanceBottom - Sprite_DrawDistanceTop] ; Sprite_DrawDistanceBottom = 008h
    sub     r1, #7
    strb    r1, [r2, #Sprite_Work0 - Sprite_DrawDistanceTop] ; Sprite_Work0 = 1
    mov     r1, #40h
    strb    r1, [r2, #Sprite_DrawDistanceHorizontal - Sprite_DrawDistanceTop] ; Sprite_DrawDistanceHorizontal = 040h
    mov     r1, #1Ch
    strh    r1, [r6, #Sprite_BboxBottom] ; Sprite_BboxBottom = 01Ch
    neg     r1, r1
    lsl     r1, 10h
    lsr     r1, 10h
    strh    r1, [r6, #Sprite_BboxTop] ; Sprite_BboxTop = -01Ch
    ldrh    r0, [r6, #Sprite_YPosition]
    sub     r0, #20h
    strh    r0, [r6, #Sprite_YPosition] ; Sprite_YPosition = Sprite_YPosition - 020h

; Sprite_OamPointer = HorizontalVanilla or HorizontalRevealed
    cmp     r4, #1
    bne     @@load_vanilla_horizontal_pillar_oam
@@load_revealed_horizontal_pillar_oam:
    mov     r1, #SpriteStatus_IgnoreProjectiles >> 8
    lsl     r1, 8
    ldr     r3, =@HorizontalRevealedPillarOamPointer
    mov     r0, #1
    mov     r2, #Sprite_BgPriority
    add     r2, r2, r6
    strb    r0, [r2]
    b       @@cont_horizontal
@@load_vanilla_horizontal_pillar_oam:
    ldr     r1, =SpriteStatus_NotDrawn|SpriteStatus_IgnoreProjectiles
    ldr     r3, =@HorizontalVanillaPillarOamPointer

@@cont_horizontal:
    ldr     r0, [r6]
    orr     r1, r0
    strh    r1, [r6, #Sprite_Status] ; Sprite_Status = Sprite_Status | (r1)
    b       @@all_common

@@all_common:
    str     r3, [r6, #Sprite_OamPointer]
    mov     r3, #Sprite_Health
    add     r2, r6, r3
    strh    r5, [r2]    ; Sprite_Health = 0
    strb    r5, [r2, #Sprite_AnimationFrame - Sprite_Health] ; Sprite_AnimationFrame = 0
    strb    r5, [r2, #Sprite_AnimationCounter - Sprite_Health] ; Sprite_AnimationCounter = 0
    strb    r5, [r2, #Sprite_SamusCollision - Sprite_Health] ; Sprite_SamusCollision = None (0)
    add     r5, #1
    strb    r5, [r2, #Sprite_Pose - Sprite_Health] ; Sprite_Pose = 1
    b       @@return

@@no_match:
    mov     r0, #0
    strh    r5, [r6] ; Sprite_Status = 0
@@return:
    pop     { r4-r6 }
    pop     { r0 }
    bx      r0
    .pool
.endfunc
.endarea
