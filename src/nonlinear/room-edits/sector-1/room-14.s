; Sector 1 - Lava Lake Annex
; show metroid molt in go mode instead of after ridley
.org Sector1Levels + 14h * LevelMeta_Size + LevelMeta_Spriteset1Event
.area 1
    .db     Event_GoMode
.endarea
