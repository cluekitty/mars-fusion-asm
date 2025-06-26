; Main Deck - Operations Ventilation
; repair maintenance crossing and add a geron
.org readptr(MainDeckLevels + 23h * LevelMeta_Size + LevelMeta_Bg1)
.area 492h
.incbin "data/rooms/S0-23-BG1.rlebg"
.endarea

.org readptr(MainDeckLevels + 23h * LevelMeta_Size + LevelMeta_Bg2)
.area 4F0h
.incbin "data/rooms/S0-23-BG2.rlebg"
.endarea

.defineregion readptr(MainDeckLevels + 52h * LevelMeta_Size + LevelMeta_Spriteset0), 12h

.autoregion
@MaintenanceShaft_Spriteset0:
    .db     05h, 0Eh, 25h
    .db     15h, 0Bh, 03h
    .db     19h, 0Ch, 12h
    .db     20h, 07h, 38h
    .db     46h, 0Bh, 22h
    .db     39h, 0Ch, 24h
    .db     0FFh, 0FFh, 0FFh
.endautoregion

.org MainDeckLevels + 23h * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_Spriteset1Event - LevelMeta_Spriteset0
    .dw     @MaintenanceShaft_Spriteset0
    .db     19h
.endarea


; ---


; Main Deck - Operations Crossing
; This room is bundled with the above as one room in RDV's database
; repair so the crossing is traversable and add a geron
.org readptr(MainDeckLevels + 24h * LevelMeta_Size + LevelMeta_Bg1)
.area 100h
.incbin "data/rooms/S0-24-BG1.rlebg"
.endarea

.org readptr(MainDeckLevels + 24h * LevelMeta_Size + LevelMeta_Bg2)
.area 0D2h
.incbin "data/rooms/S0-24-BG2.rlebg"
.endarea

.org readptr(MainDeckLevels + 24h * LevelMeta_Size + LevelMeta_Clipdata)
.area 61h
.incbin "data/rooms/S0-24-Clip.rlebg"
.endarea

.defineregion readptr(MainDeckLevels + 24h * LevelMeta_Size + LevelMeta_Spriteset0), 03h

.autoregion
@MaintenanceCrossing_Spriteset0:
    .db     07h, 0Ch, 24h
    .db     0FFh, 0FFh, 0FFh
.endautoregion

.org MainDeckLevels + 24h * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_Spriteset1Event - LevelMeta_Spriteset0
    .dw     @MaintenanceCrossing_Spriteset0
    .db     19h
.endarea
