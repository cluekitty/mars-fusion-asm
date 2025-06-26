; Sector 2 - Ripper Roost
; move bottom crumble block up one to prevent softlocks without bombs
.if ANTI_SOFTLOCK
.org readptr(Sector2Levels + 32h * LevelMeta_Size + LevelMeta_Clipdata)
.area 10Ah
.incbin "data/rooms/S2-32-Clip.rlebg"
.endarea
.endif
