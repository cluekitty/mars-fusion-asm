; Sector 1 - Moto Manor
; show metroid molt in go mode instead of after ridley
.org Sector1Levels + 0Ch * LevelMeta_Size + LevelMeta_Spriteset1Event
.area 1
    .db     Event_GoMode
.endarea
