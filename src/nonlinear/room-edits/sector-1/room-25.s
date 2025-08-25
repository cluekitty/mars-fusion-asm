; Sector 1 - Charge Core Lower Access
; Slightly adjust exit-distance from door with gadora to prevent instant damage if the gadora is not defeated.

.org Sector1Doors + 53h * DoorEntry_Size + DoorEntry_ExitDistanceX
.area 1
    .db     23h
.endarea
