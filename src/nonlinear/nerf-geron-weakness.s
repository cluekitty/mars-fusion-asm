; Enforces intended Geron weaknesses (missiles, super missiles, power bombs)

; Atmospheric Geron weaknesses
.org SpriteStats + AtmosphericStabilizerParasite_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_Missiles)

; Missile Geron weaknesses
.org SpriteStats + XBarrierCoreNormal1_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_Missiles)

.org SpriteStats + XBarrierCoreNormal2_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_Missiles)

.org SpriteStats + XBarrierCoreNormal3_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_Missiles)

; Super Missile Geron weaknesses
.org SpriteStats + XBarrierCoreSuper1_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_SuperMissiles)

.org SpriteStats + XBarrierCoreSuper2_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_SuperMissiles)

.org SpriteStats + XBarrierCoreSuper3_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_SuperMissiles)

.org SpriteStats + XBarrierCoreSuper4_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_SuperMissiles)

.org SpriteStats + XBarrierCoreSuper5_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_SuperMissiles)

.org SpriteStats + XBarrierCoreSuper6_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_SuperMissiles)

.org SpriteStats + XBarrierCoreSuper7_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_SuperMissiles)

.org SpriteStats + XBarrierCoreSuper8_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_SuperMissiles)

; Power Bomb Geron weaknesses
.org SpriteStats + XBarrierCorePower1_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_PowerBombs)

.org SpriteStats + XBarrierCorePower2_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_PowerBombs)

.org SpriteStats + XBarrierCorePower3_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_PowerBombs)

.org SpriteStats + XBarrierCorePower4_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_PowerBombs)

.org SpriteStats + XBarrierCorePower5_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_PowerBombs)

.org SpriteStats + XBarrierCorePower6_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_PowerBombs)

.org SpriteStats + XBarrierCorePower7_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_PowerBombs)

.org SpriteStats + XBarrierCorePower8_Id * SpriteStats_Size + SpriteStats_Weaknesses
    .db     (1 << SpriteWeakness_PowerBombs)

; Changes the clipdata passed into function XBarrierCoreSetCollision (08029cf0h)
; to not allow the player to pass through using Screw Attack or Speed Booster

; Missile Geron
.org 08029E68h
    mov r0, ClipdataAction_MakeSolid

; Power Bomb Geron
.org 08042310h
    mov r0, ClipdataAction_MakeSolid



; Make Super Missile Geron passable if it hasn't formed yet, but impoassable once it has formed.

; Changes the function in SuperMissileGeronInit, to only set collision if pose is not Spawning_From_X
.autoregion
.align 2
.func @SuperGeronInitHijack
    push    { lr }
    ldr     r1, =CurrentSprite
    add     r1, Sprite_Pose
    ldrb    r0, [r1, #0]
    cmp     r0, #5Ah        ; SPRITE_POSE_SPAWNING_FROM_X
    beq     @@return
    mov     r0, ClipdataAction_MakeSolid
    bl 	    GeronSetCollision
@@return:
    pop     { pc }
.endfunc
.pool
.endautoregion

.org 08041FA0h      ; in SuperMissileGeronInit
.area 6, 0
    bl @SuperGeronInitHijack
.endarea

; Call GeronSetCollision at the end of SuperMissileGeronIdleInit
.autoregion
.align 2
.func @SuperGeronIdleInitHijack
    push    { lr }
    mov     r0, ClipdataAction_MakeSolid
    bl      GeronSetCollision

    ; Restore original code
    add     r2, r1, #00
    add     r2, #24h
    mov     r3, #0
    mov     r0, #2
    strb    r0, [r2, #0]
    pop     { pc }
.endfunc
.endautoregion

.org 08041FB2h  ; end of SuperMissileGeronIdleInit
.area 10
    ; We need to manually save/restore lr here
    push    { lr }
    bl @SuperGeronIdleInitHijack
    pop     { pc }
.endarea