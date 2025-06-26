; Main Deck - Operations Deck
; change operations room lv4 security door to lv0 security
; allow missile hatch to be destroyed from both sides
.org readptr(MainDeckLevels + 0Dh * LevelMeta_Size + LevelMeta_Bg1)
.area 2DBh
.incbin "data/rooms/S0-0D-BG1.rlebg"
.endarea

.org readptr(MainDeckLevels + 0Dh * LevelMeta_Size + LevelMeta_Clipdata)
.area 0C3h
.incbin "data/rooms/S0-0D-Clip.rlebg"
.endarea

; Extends the hitbox of the shootable missile hatch to be able to be hit from both sides.
.org 0804193Eh ; Editing code in MissileHatchInit
.area 02h
    mov     r0, #60h
.endarea
