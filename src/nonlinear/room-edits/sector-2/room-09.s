; Sector 2 - Zoro Zig-Zag
; moves zoro coocoons to prevent blocking morph ball tunnels
.org readptr(Sector2Levels + 09h * LevelMeta_Size + LevelMeta_Spriteset1) + (7 * Spriteset_SpriteSize)
.area 9
    .db 25h, 17h, 14h
    .db 2Ah, 1Bh, 14h
    .db 32h, 1Bh, 14h
.endarea

.org readptr(Sector2Levels + 09h * LevelMeta_Size + LevelMeta_Spriteset2) + (0Bh * Spriteset_SpriteSize)
.area 9
    .db 26h, 17h, 14h
    .db 2Ah, 1Bh, 14h
    .db 32h, 1Bh, 14h
.endarea
