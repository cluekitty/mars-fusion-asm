; Enables the in-game debug menu, accessed via the Samus status screen.
.definelabel DebugFlag, 03000000h
.definelabel UpdateFreeMovement_Debug, 0800E684h
.definelabel ProcessPauseButtonPress, 08068870h
.definelabel DebugMenuDrawNumber, 0807E520h
.definelabel DebugSectionInfo, 0858211Ch

.sym off
.definelabel NonGameplayFlag_PauseScreen, 2
.definelabel NoneGameplay_DebugMenuEditingValue, 7
.definelabel DebugSection_Top, 0
.definelabel DebugSection_Bottom, 1
.definelabel DebugSection_Left, 2
.definelabel DebugSection_Right, 3
.definelabel DebugSection_Section,4
.definelabel DebugSection_Len, 5h
.definelabel DebugSection_Beam, 0h
.definelabel DebugSection_Missile, 01h
.definelabel DebugSection_Bomb, 02h
.definelabel DebugSection_Suit, 03h
.definelabel DebugSection_Misc, 04h
.definelabel DebugSection_EnergyCurrent, 05h
.definelabel DebugSection_EnergyMax, 06h
.definelabel DebugSection_SupplyUnused, 07h
.definelabel DebugSection_Metroid, 07h
.definelabel DebugSection_MissileCurrent, 08h
.definelabel DebugSection_MissileMax, 09h
.definelabel DebugSection_PBombCurrent, 0Ah
.definelabel DebugSection_PBombMax, 0Bh
.definelabel DebugSection_AbilityCount, 0Ch
.definelabel DebugSection_Security, 0Dh
.definelabel DebugSection_Map, 0Eh
.definelabel DebugSection_Event, 0Fh
.definelabel DebugSection_SubEvent, 10h
.definelabel DebugSection_InGameTime, 11h
.definelabel DebugSection_QuickSave, 12h
.definelabel DebugSection_All, 0FFh
.sym on

.org 08076A2Eh ; Modifies code in PauseScreenInit
    mov     r0, r9
    strb    r0, [r4, #2]

.org 0801FC84h ; Modifies code in GunshipInit (checks if debug is enabled, we remove the check)
.area 0801FC8Ch - 0801FC84h, 0
.endarea

;.org 0856F71Ch
.autoregion
@Debug_Map_3:
.incbin "data/debug-map.gfx"
.endautoregion

.org 08076B10h
    .dw @Debug_Map_3

.org 08573EA0h
.area 25Ch, 0
.incbin "data/debug-menu-vram.bin"
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
    ldr     r0, =@CheckEnableNoClip
    mov     pc, r0
    .pool
.endarea
.definelabel @ReturnFromNoClipCheck, org()+1


/* Make Unused Supply section for metroids */
.org 0807D4CCh
.area 4
    .dw     0807D5D4h
.endarea

.org DebugSectionInfo + (DebugSection_Metroid * DebugSection_Len)
.area 5
    .db     4, 4, 1Bh, 1Ch, DebugSection_Metroid
.endarea

; Editing the value
.org 0807E2A8h
.area 0807E2C0h-., 0
    bl      @DebugMenuModifyHealthAndAmmoHighjack
.endarea

; Drawing the value
.org 0807E4A8h
    sub     r0, #07h
.org 0807E4B6h
.area 0807E4C8h-., 0
    ldr     r4, =@DebugMenuDrawHealthAndAmmoHighjack
    mov     pc, r4
    .pool
.endarea
.definelabel @ReturnFromDebugMenuDrawingHighjack, org()+1


; Allow speeding or slowing noclip speed
.org 0800E6F0h
.area 0800E702h-., 0
    ldr     r0, =@NoClipSpeedHighjack
    mov     pc, r0
    .pool
.endarea
.definelabel @ReturnFromNoClipSpeedHighjack, org()+1


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
    ldr     r1, =@ReturnFromNoClipCheck ; Return and break out of jump table
    bx      r1

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
    ldr     r0, =SubGameMode1
    ldrh    r1, [r0]
    add     r1, #01h
    strh    r1, [r0]
    ldr     r0, =NonGameplayFlag
    mov     r1, #NonGameplayFlag_PauseScreen
    strb    r1, [r0]

@@return:
    ldr     r1, =@ReturnFromNoClipCheck
    bx      r1
    .pool
.endfunc

    .align 2
@DebugMenuModifyHealthAndAmmoHighjack:
@@check_max_energy:
    cmp     r3, #06h
    bne     @@check_metroids
    ldr     r5, =SamusUpgrades+SamusUpgrades_MaxEnergy
    sub     r2, r5, #02h
    mov     r8, r2
    mov     r1, #03h    ; length of numbers you can choose left/right
    mov     r7, #02h    ; what is r7?
    mov     r0, #00h
    mov     r9, r0      ; type of refill, 0 = energy, 1 = missile/metroid, 2 = pbomb
    push    { r7 }
    ldr     r7, =0807E314h+1
    mov     lr, r7
    pop     { r7 }
    bx      lr
    .pool
@@check_metroids:
    cmp     r3, #07h
    bne     @@check_next
    ldr     r5, =TotalMetroidCount
    mov     r8, r5
    ldr     r5, =PermanentUpgrades+PermanentUpgrades_InfantMetroids
    mov     r1, #01h    ; length of numbers you can choose length left/right
    mov     r7, #02h
@@set_increment_type:
    mov     r0, #01h
    mov     r9, r0      ; type of refill, 0 = energy, 1 = missile/metroid, 2 = pbomb
    push    { r7 }
    ldr     r7, =0807E314h+1
    mov     lr, r7
    pop     { r7 }
    bx      lr
    .pool

@@check_next:
    push    { r7 }
    ldr     r7, =0807E2C0h+1
    mov     lr, r7
    pop     { r7 }
    bx      lr
    .pool

    .align 2
@DebugMenuDrawHealthAndAmmoHighjack:
    ldr     r4, =PermanentUpgrades
    ldrb    r0, [r4, #PermanentUpgrades_InfantMetroids]
    mov     r1, #DebugSection_Metroid
    bl      DebugMenuDrawNumber
    ldr     r4, =SamusUpgrades
    ldrb    r0, [r4, #SamusUpgrades_CurrMissiles]
    mov     r1, #DebugSection_MissileCurrent
    bl      DebugMenuDrawNumber
    ldrb    r0, [r4, #SamusUpgrades_MaxMissiles]
    mov     r1, #DebugSection_MissileMax
    bl      DebugMenuDrawNumber
    ldr     r0, =@ReturnFromDebugMenuDrawingHighjack
    bx      r0
    .pool

    .align 2
@NoClipSpeedHighjack:
@@speed_up_noclip:
    ; r1 contains HeldInput
    ; r5 contains X-axis movement
    ; r7 contains Y-axis movement
    mov     r0, #(1 << Button_R) >> 4
    lsl     r0, #04h
    and     r0, r1
    cmp     r0, #00h
    beq     @@slow_down_noclip
    lsl     r5, #01h
    lsl     r7, #01h

@@slow_down_noclip:
    mov     r0, #(1 << Button_L) >> 4
    lsl     r0, #04h
    and     r0, r1
    cmp     r0, #00h
    beq     @@return_from_highjack
    ldr     r0, =0FFFFh
    lsl     r5, #10h
    asr     r5, #11h
    and     r5, r0
    lsl     r7, #10h
    asr     r7, #11h
    and     r7, r0

@@return_from_highjack:
    ldr     r0, =@ReturnFromNoClipSpeedHighjack
    bx      r0
    .pool
.endautoregion
