; Sector 1 - Atmospheric Stabilizer Southeast
; show metroid molt in go mode instead of after ridley
.org Sector1Levels + 0Fh * LevelMeta_Size + LevelMeta_Spriteset1Event
.area 1
    .db     Event_GoMode
.endarea
