; Sector 1 - Atmospheric Stabilizer Northwest
; show metroid molt in go mode instead of after ridley
.org Sector1Levels + 04h * LevelMeta_Size + LevelMeta_Spriteset1Event
.area 1
    .db     Event_GoMode
.endarea
