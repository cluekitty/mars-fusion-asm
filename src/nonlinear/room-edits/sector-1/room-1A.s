; Sector 1 - Ridley Arena Access
; Slightly adjust exit-distance from door with gadora to prevent instant damage if the gadora is not defeated.

.org Sector1Doors + 39h * DoorEntry_Size + DoorEntry_ExitDistanceX
.area 1
    .db     23h
.endarea
