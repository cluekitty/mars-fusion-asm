/*  Sets the default speaker mode to Stereo
*/
.org DefaultStereoFlagPointer
.area 4
    .dw     DefaultStereoFlag
.endarea

.org 0809E8BAh
; Modifying OAM setup in FileSelectInit()
.area 4
    bl      @FileSelectInitHighjack_SetupOam
.endarea

.org 0809E8DEh
; Highjacks FileSelectInit(), enables stereo automatically
.area 4
    bl      @FileSelectInitHighjack_CheckEnableStereo
.endarea

.org 0809F670h
; Highjacks FileSelectSetupOam()
.area 4
    bl      @FileSelectSetupOamHighjack
.endarea

.autoregion
DefaultStereoFlag:
    .db     00
    .align 2
@FileSelectInitHighjack_SetupOam:
    mov     r1, #66h
    ldr     r0, =DefaultStereoFlag
    ldrb    r0, [r0]
    cmp     r0, #01
    bne     @@mono
    mov     r1, #0AAh
@@mono:
    mov     r0, #09h
    bx      lr
    .pool

@FileSelectSetupOamHighjack:
    ; do not destroy r0
    push    { r4 }
    ldr     r1, =087407E0h
    ldr     r4, =DefaultStereoFlag
    ldrb    r4, [r4]
    cmp     r4, #1
    bne     @@mono
    add     r1, #10h
@@mono:
    str     r1, [r0]
    pop     { r4 }
    bx      lr
    .pool

@FileSelectInitHighjack_CheckEnableStereo:
    push    { lr }
    ldr     r1, =DefaultStereoFlag
    ldrb    r1, [r1]
    cmp     r1, #1
    bne     @@return
    mov     r0, #01
    ldr     r1, =030016E8h          ; Non-Gameplay Ram for File Select, Part of FileSelectOam
    strb    r0, [r1, #09]
    ldr     r1, =03001704h          ; Non-Gameplay Ram for File Select, Part of FileSelectOam
    strb    r0, [r1, #09]
    mov     r0, #02000000h >> 12h
    lsl     r0, #12h
    bl      080024ECh               ; takes 1 argument in r0
@@return:
    bl      FileSelectDrawAllOam    ; FileSelectDrawAllOam
    pop     { r0 }
    bx      r0
    .pool
.endautoregion
