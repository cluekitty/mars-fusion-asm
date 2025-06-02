; Sector 5 - Ripper Road
; replace lv0 door to arctic containment with an open hatch
.org readptr(Sector5Levels + 1Ah * LevelMeta_Size + LevelMeta_Bg1)
.area 1B3h
.incbin "data/rooms/S5-1A-BG1.rlebg"
.endarea

.org readptr(Sector5Levels + 1Ah * LevelMeta_Size + LevelMeta_Clipdata)
.area 0A4h
.incbin "data/rooms/S5-1A-Clip.rlebg"
.endarea

.org Sector5Doors + 37h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_OpenHatch
.endarea
