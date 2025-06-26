; Sector 4 - Security Bypass
; prevent several softlocks without bombs
.if ANTI_SOFTLOCK
.org readptr(Sector4Levels + 22h * LevelMeta_Size + LevelMeta_Bg1)
.area 57Ah
.incbin "data/rooms/S4-22-BG1.rlebg"
.endarea

.org readptr(Sector4Levels + 22h * LevelMeta_Size + LevelMeta_Clipdata)
.area 1B1h
.incbin "data/rooms/S4-22-Clip.rlebg"
.endarea
.endif
