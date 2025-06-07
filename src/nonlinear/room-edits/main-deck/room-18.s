; Main Deck - Sector Hub
; keep main elevator always active
.defineregion readptr(MainDeckLevels + 18h * LevelMeta_Size + LevelMeta_Spriteset0), 27h

.org MainDeckLevels + 18h * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_Spriteset2Event - LevelMeta_Spriteset0
    .dw     readptr(MainDeckLevels + 18h * LevelMeta_Size + LevelMeta_Spriteset1)
    .db     02h
    .db     0
    .skip 2
    .dw     NullSpriteset
    .db     0
.endarea
