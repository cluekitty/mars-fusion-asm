; Enables the in-game debug menu, accessed via the Samus status screen.
.definelabel UpdateFreeMovement_Debug, 0800E684h
.definelabel ProcessPauseButtonPress, 08068870h
.definelabel DebugFlag, 03000000h

.sym off
.definelabel NonGameplayFlag_PauseScreen, 2
.sym on

.org 08076A2Eh ; Modifies code in PauseScreenInit
    mov     r0, r9
    strb    r0, [r4, #2]

.org 0801FC84h ; Modifies code in GunshipInit (checks if debug is enabled, we remove the check)
.area 0801FC8Ch - 0801FC84h, 0
.endarea

; Enable vanilla debug flag, this is used for various purposes, but in this case
; we will see the invisible targets and triggers used in the game (such as for)
; x-parasite targets or killing required enemies for opening a door in a puzzle.
.org 0800E4FCh ; Modifies code in InitAndLoadGenerics
.area 4
    bl      EnableDebug
.endarea

.org 080805E4h ; Modifies code in Sram_ResetForDemo
.area 4
    bl      EnableDebug
.endarea

.org 0808070Ch ; Modifies code in Sram_CheckLoadSaveFile
.area 4
    bl      EnableDebug
.endarea

.org 08000874h ; Modifies code in InitializeGame
.area 4
    bl      EnableDebug
.endarea

.org 0800DDE0h
.area 0800DE04h-., 0
    ldr     r0, =@CheckEnableNoClip+1
    bx      r0
    .pool
.endarea
.definelabel @ReturnFromNoClipCheck, org()+1

.autoregion
    .align 2
.func EnableDebug
    push    { r0-r1, lr }
    ldr     r1, =DebugFlag
    mov     r0, #01h
    strb    r0, [r1]
    pop     { r0-r1, pc }
    .pool
.endfunc

/* NOTES
    Hold Button_Select, Press Button_A to enable No Clip.
    While in No Clip mode:
    * hold Button_R to move more quickly
    * press Button_Start to center the camera on Samus and disable scrolling.
      This lets you see all GFX of the room, including the normally hidden borders.
    * press Button_Select to exit No Clip mode.
    * Samus cannot be damaged.
    * Samus cannot interact with level geometry, door transitions, or sprites.

*/
    .align 2
.func @CheckEnableNoClip
    ldr     r0, =DebugFlag
    ldrb    r0, [r0]
    cmp     r0, #00h
    beq     @@if_false
    ldr     r0, =ToggleInput
    ldrh    r0, [r0]
    mov     r1, #1 << Button_A
    and     r0, r1                  ; If Button_A Pressed ...
    cmp     r0, #00h
    beq     @@if_false
    ldr     r0, =HeldInput
    ldrh    r0, [r0]
    mov     r1, #1 << Button_Select
    mov     r2, r1
    and     r0, r2                  ; ... while holding Button_Select ...
    cmp     r0, r1
    bne     @@if_false
@@if_true:
    ldr     r0, =TimeStopTimer
    ldrh    r0, [r0]
    cmp     r0, #00h
    bne     @@if_false
    ldr     r0, =SubGameMode1
    mov     r1, #06h                 ; ... then enable no-clip mode.
    strh    r1, [r0]
    ldr     r0, =@ReturnFromNoClipCheck ; Return and break out of jump table
    bx      r0

@@if_false: ; Restore vanilla functionality
    ldr     r0, =ToggleInput
    ldr     r1, =ButtonAssignments
    ldrh    r2, [r0]
    ldrh    r0, [r1, #ButtonAssignments_Pause]
    and     r0, r2
    cmp     r0, #00h
    beq     @@return
    bl      ProcessPauseButtonPress
    cmp     r0, #FALSE
    beq     @@return
    ldr     r1, =SubGameMode1
    ldrh    r0, [r1]
    add     r0, #01h
    strh    r0, [r1]
    ldr     r1, =NonGameplayFlag
    mov     r0, #NonGameplayFlag_PauseScreen
    strb    r0, [r1]

@@return:
    ldr     r1, =@ReturnFromNoClipCheck
    bx      r1
    .pool
.endfunc
.endautoregion
