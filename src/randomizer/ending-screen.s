.org SeedHashPointersPointer
.area 4
    .dw     SeedHashPointers
.endarea

.autoregion DataFreeSpace, DataFreeSpaceEnd
    .align 4
SeedHashPointers:
    .dw     SeedHashPart1
    .dw     SeedHashPart2
    .dw     SeedHashPart3
.endautoregion
.autoregion DataFreeSpace, DataFreeSpaceEnd
    .align 2
SeedHashPart1:
    .string 10h, "[INDENT]Seed Hash Part 1"
    .fill 3Eh - (. - SeedHashPart1), 80h
    .dh     0FF00h

    .align 2
SeedHashPart2:
    .string 08h, "[INDENT]Seed Hash Part 2"
    .fill 3Eh - (. - SeedHashPart2), 80h
    .dh     0FF00h

    .align 2
SeedHashPart3:
    .string 04h, "[INDENT]Seed Hash Part 3"
    .fill 3Eh - (. - SeedHashPart3), 80h
    .dh     0FF00h

.endautoregion


; 06016800 - OBJ address that's not used, maybe can be used for drawing text


.org 080A2FD8h
; Highjack in EndingImageInit
.area 4
    bl      @EndingImageInitHighjack
.endarea

.autoregion
    .align 2
@EndingImageInitHighjack:
    push    { r0-r7, lr }
    mov     r4, r8
    push    { r4 }
    bl      ResetFreeOam
    sub     sp, #04
    mov     r0, #20h        ; bitSize
    str     r0, [sp]

    mov     r0, #03         ; General Purpose Copy
    mov     r1, #00         ; fill value
    ldr     r2, =06013800h  ; Dest
    mov     r3, #3000h >> 8 ; Size
    lsl     r3, #08h
    bl      BitFill

    mov     r0, #20h        ; bitSize
    str     r0, [sp]
    mov     r0, #03         ; General Purpose Copy
    mov     r1, #00         ; fill value
    ldr     r2, =02000000h >> 18h
    lsl     r2, #18h        ; Dest
    mov     r3, #3000h >> 8
    lsl     r3, #08h        ; size
    bl      BitFill

    mov     r0, #00
    mov     r8, r0
@@render_seed_line_loop:
    ldr     r1, =SeedHashPointers
    lsl     r2, r0, #02
    ldr     r6, [r1, r2]
    mov     r2, #800h >> 4
    lsl     r2, #04
    mul     r2, r0
    ldr     r7, =02000000h  ; Scratch Ram
    add     r7, r2

@@render_message:
    mov     r5, #0

@@render_message_loop:
    ldrh    r4, [r6]
    mov     r0, #0FFh
    lsl     r0, #08h
    cmp     r0, r4
    beq     @@seed_line_inc
    mov     r0, #0FEh
    lsl     r0, #08h
    cmp     r0, r4
    beq     @@seed_line_inc
    lsr     r0, r4, #08h
    cmp     r0, #80h
    bne     @@get_char_width
    lsl     r0, r4, #18h
    lsr     r0, #18h
    add     r5, r0
    b       @@render_message_loop_inc

@@get_char_width:
    mov     r0, r4
    bl      GetCharWidth

@@render_char:
    mov     r2, r0
    mov     r1, r7
    asr     r0, r5, #3
    lsl     r0, #5
    add     r1, r0
    mov     r0, #0
    str     r0, [sp]
    mov     r0, r4
    lsl     r3, r5, #20h - 3
    lsr     r3, #20h - 3
    add     r5, r2
    bl      RenderChar

@@render_message_loop_inc:
    add     r6, #2
    b       @@render_message_loop

@@seed_line_inc:
    mov     r0, r8
    add     r0, #01
    mov     r8, r0
    cmp     r0, #3
    beq     @@transfer_to_vram
    b       @@render_seed_line_loop

@@transfer_to_vram:
    ldr     r3, =DMA3
    ldr     r2, =DMA_ENABLE | DMA_TYPE_32BIT | 1800h / 4
    ldr     r1, =06013800h  ; OBJ VRAM Graphics
    ldr     r0, =02000000h  ; Scratch Ram
    str     r0, [r3, #DMA_SAD]
    str     r1, [r3, #DMA_DAD]
    str     r2, [r3, #DMA_CNT]
    ldr     r0, [r3, #DMA_CNT]

@@load_text_palette:
    ldr     r2, =DMA_ENABLE | 10h
    ldr     r1, =050003E0h  ; Palette RAM Destination
    ldr     r0, =08565988h  ; Text Palette
    str     r0, [r3, #DMA_SAD]
    str     r1, [r3, #DMA_DAD]
    str     r2, [r3, #DMA_CNT]
    ldr     r0, [r3, #DMA_CNT]
@@return:
    add     sp, #04
    pop     { r4 }
    mov     r8, r4
    pop     { r0-r7, pc }
    .pool
.endautoregion


; Uncomment the below to load directly into credits for testing
/*
.sym off
.org 08000870h
.area 4
    bl      @init_to_credits
.endarea

.autoregion
    .align 2
@init_to_credits:
    push    { r1, lr }
    ldr     r0, =GameMode
    mov     r1, 0Bh ; credits
    strh    r1, [r0]
    pop     { r1, pc }
    .pool
.endautoregion
.sym on
*/
