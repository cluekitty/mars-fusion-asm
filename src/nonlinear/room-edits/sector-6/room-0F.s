; Sector 6 - Zozoro Wine Cellar
; change the reforming bomb block to a never reforming bomb block to prevent
; softlocking from running out of power bombs
.if ANTI_SOFTLOCK
.org readptr(Sector6Levels + 0Fh * LevelMeta_Size + LevelMeta_Clipdata)
.area 033h
.incbin "data/rooms/S6-0F-Clip.rlebg"
.endarea
.endif
