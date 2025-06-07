; Sector 2 - Crumble City
; replace one of the shot blocks in the morph tunnel below the top item
; with a crumble block to prevent softlocks without bombs
.if ANTI_SOFTLOCK
.org readptr(Sector2Levels + 36h * LevelMeta_Size + LevelMeta_Clipdata)
.area 121h
.incbin "data/rooms/S2-36-Clip.rlebg"
.endarea
.endif
