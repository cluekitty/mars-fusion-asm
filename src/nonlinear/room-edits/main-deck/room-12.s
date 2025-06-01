; Main Deck - Central Nexus
; keep power bomb geron always loaded
.defineregion readptr(MainDeckLevels + 12h * LevelMeta_Size + LevelMeta_Spriteset0), 03h

.org MainDeckLevels + 12h * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_Spriteset2Event - LevelMeta_Spriteset0
    .dw     readptr(MainDeckLevels + 12h * LevelMeta_Size + LevelMeta_Spriteset1)
    .db     33h
    .db     0
    .skip 2
    .dw     NullSpriteset
    .db     0
.endarea
