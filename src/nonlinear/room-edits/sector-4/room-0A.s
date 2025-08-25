; Sector 4 - Broken Bridge
; Slightly adjust exit-distance from door with gadora to prevent instant damage if the gadora is not defeated.

.org Sector4Doors + 40h * DoorEntry_Size + DoorEntry_ExitDistanceX
.area 1
    .db     100h - 23h
.endarea
