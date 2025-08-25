; Main Deck - Crew Quarters West
; remove power bomb geron

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
