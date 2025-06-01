; Sector 1 - Hornoad Housing
; have hornoads spawn by x forming them
.org readptr(Sector1Levels + 2Eh * LevelMeta_Size + LevelMeta_Spriteset0)
.area 15
    .skip 6
    .db 07h, 08h, 16h
    .skip 3
    .db 07h, 0Ah, 16h
.endarea
