; Sector 2 - Nettori Access
; change winged kihunter below eyedoor into a grounded kihunter
; remove 4 tiles to prevent the above kihunter from jumping through solids
.org readptr(Sector2Levels + 14h * LevelMeta_Size + LevelMeta_Bg1)
.area 4F6h
.incbin "data/rooms/S2-14-BG1.rlebg"
.endarea

.org readptr(Sector2Levels + 14h * LevelMeta_Size + LevelMeta_Clipdata)
.area 1AEh
.incbin "data/rooms/S2-14-Clip.rlebg"
.endarea

.org readptr(Sector2Levels + 14h * LevelMeta_Size + LevelMeta_Spriteset0) + 3 * 3
.area 3
    .db     11h, 15h, 26h
.endarea

.org readptr(Sector2Levels + 22h * LevelMeta_Size + LevelMeta_Spriteset0) + 2 * 3
.area 3
    .db     11h, 15h, 26h
.endarea
