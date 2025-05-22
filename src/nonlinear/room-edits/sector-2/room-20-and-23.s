; Sector 2 - Eastern Shaft
; add ledge to allow climbing frozen enemies from middle doors to top doors
; removed 2 vine tiles to prevent dangerous nettori
.defineregion readptr(Sector2Levels + 20h * LevelMeta_Size + LevelMeta_Clipdata), 21Fh
.defineregion readptr(Sector2Levels + 23h * LevelMeta_Size + LevelMeta_Bg1), 46Ah
.defineregion readptr(Sector2Levels + 23h * LevelMeta_Size + LevelMeta_Clipdata), 1C3h

.org readptr(Sector2Levels + 20h * LevelMeta_Size + LevelMeta_Bg1)
.area 46Ah
.incbin "data/rooms/S2-20-BG1.rlebg"
.endarea

.autoregion EOF, PatcherFreeSpace-1
@S2_EasternShaftVines_Clipdata:
.incbin "data/rooms/S2-20-Clip.rlebg"
.endautoregion

.org Sector2Levels + 20h * LevelMeta_Size + LevelMeta_Clipdata
.area 4
    .dw     @S2_EasternShaftVines_Clipdata
.endarea


.autoregion EOF, PatcherFreeSpace-1
@S2_EasternShaft_Bg1:
.incbin "data/rooms/S2-23-BG1.rlebg"
.endautoregion

.org Sector2Levels + 23h * LevelMeta_Size + LevelMeta_Bg1
.area 4
    .dw     @S2_EasternShaft_Bg1
.endarea

.autoregion EOF, PatcherFreeSpace-1
@S2_EasternShaft_Clipdata:
.incbin "data/rooms/S2-23-Clip.rlebg"
.endautoregion

.org Sector2Levels + 23h * LevelMeta_Size + LevelMeta_Clipdata
.area 4
    .dw     @S2_EasternShaft_Clipdata
.endarea
