; Main Deck - Silo Entry
; move zoro cocoon
.org readptr(MainDeckLevels + 30h * LevelMeta_Size + LevelMeta_Spriteset0)
.area 03h
    .db     15h, 05h, 14h
.endarea

.org readptr(MainDeckLevels + 30h * LevelMeta_Size + LevelMeta_Spriteset1)
.area 03h
    .db     15h, 05h, 14h
.endarea
