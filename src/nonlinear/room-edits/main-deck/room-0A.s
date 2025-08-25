; Main Deck - Crew Quarters East
; Slightly adjust exit-distance from door with gadora to prevent instant damage if the gadora is not defeated.

.org MainDeckDoors + 56h * DoorEntry_Size + DoorEntry_ExitDistanceX
.area 1
    .db     100h - 23h
.endarea
