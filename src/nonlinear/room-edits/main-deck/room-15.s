; Main Deck - Concourse
; remove geron in front of recharge station
.defineregion readptr(MainDeckLevels + 15h * LevelMeta_Size + LevelMeta_Spriteset0), 12h

.org MainDeckLevels + 15h * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_MapX - LevelMeta_Spriteset0
    .dw     readptr(MainDeckLevels + 15h * LevelMeta_Size + LevelMeta_Spriteset1)
    .db     19h
    .db     63h
    .skip 2
    .dw     readptr(MainDeckLevels + 15h * LevelMeta_Size + LevelMeta_Spriteset2)
    .db     19h
    .db     0
    .skip 2
    .dw     NullSpriteset
    .db     0
.endarea
