; Main Deck - Arachnus Arena
; remove sprite layer that removes Arachnus during the escape
.org MainDeckLevels + 26h * LevelMeta_Size + LevelMeta_Spriteset1Event
.area LevelMeta_Spriteset2Event - LevelMeta_Spriteset1Event
    .db     0
    .skip 2
    .dw     NullSpriteset
    .db     0
.endarea
