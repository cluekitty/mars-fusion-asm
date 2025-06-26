; Sector 6 - X-BOX Arena
; change the top crumble block into a shot block to mitigate accidentally
; entering a point of no return
.org readptr(Sector6Levels + 10h * LevelMeta_Size + LevelMeta_Clipdata)
.area 0B3h
.incbin "data/rooms/S6-10-Clip.rlebg"
.endarea
