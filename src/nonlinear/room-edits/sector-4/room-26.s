; Sector 4 - Aquarium Kago Storage
; make kago always block missile tank
.defineregion readptr(Sector4Levels + 26h * LevelMeta_Size + LevelMeta_Spriteset0), 24h

.org Sector4Levels + 26h * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_Spriteset2Event - LevelMeta_Spriteset0
    .dw     readptr(Sector4Levels + 26h * LevelMeta_Size + LevelMeta_Spriteset1)
    .skip 1
    .db     0
    .skip 2
    .dw     NullSpriteset
    .db     0
.endarea
