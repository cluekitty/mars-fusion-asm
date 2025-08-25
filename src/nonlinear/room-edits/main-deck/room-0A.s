; Main Deck - Crew Quarters West
; remove power bomb geron
; Slightly adjust exit-distance from door with gadora to prevent instant damage if the gadora is not defeated.

.defineregion readptr(MainDeckLevels + 0Ch * LevelMeta_Size + LevelMeta_Spriteset1), 0Fh

.org MainDeckLevels + 0Ch * LevelMeta_Size + LevelMeta_Spriteset1Event
.area LevelMeta_MapX - LevelMeta_Spriteset1Event
    .db     Event_GoMode
    .skip 2
    .dw     readptr(MainDeckLevels + 0Ch * LevelMeta_Size + LevelMeta_Spriteset2)
    .db     33h
    .db     0
    .skip 2
    .dw     NullSpriteset
    .db     0
.endarea

.org MainDeckDoors + 56h * DoorEntry_Size + DoorEntry_ExitDistanceX
.area 1
    .db     100h - 23h
.endarea
