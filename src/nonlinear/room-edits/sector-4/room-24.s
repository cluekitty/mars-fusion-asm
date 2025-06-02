; Sector 4 - Drain Pipe
; keep puffer always active
.defineregion readptr(Sector4Levels + 24h * LevelMeta_Size + LevelMeta_Spriteset1), 2Ah

.org Sector4Levels + 24h * LevelMeta_Size + LevelMeta_Spriteset1Event
.area LevelMeta_MapX - LevelMeta_Spriteset1Event
    .db     Event_WaterLevelLowered
    .skip 2
    .dw     readptr(Sector4Levels + 24h * LevelMeta_Size + LevelMeta_Spriteset2)
    .db     23h
    .db     0
    .skip 2
    .dw     NullSpriteset
    .db     0
.endarea
