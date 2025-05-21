; Sector 6 - Big Shell 1
; Remove the crumble block into the long morph tunnel to prevent softlocks
; without power bombs
.org readptr(Sector6Levels + 1Bh * LevelMeta_Size + LevelMeta_Bg1)
.area 1EFh
.incbin "data/rooms/S6-1B-BG1.rlebg"
.endarea

.org readptr(Sector6Levels + 1Bh * LevelMeta_Size + LevelMeta_Clipdata)
.area 0B5h
.incbin "data/rooms/S6-1B-Clip.rlebg"
.endarea
