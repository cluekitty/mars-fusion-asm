; Sector 6 - Data Access
; Slightly adjust exit-distance from door with gadora to prevent instant damage if the gadora is not defeated.

.org Sector6Doors + 18h * DoorEntry_Size + DoorEntry_ExitDistanceX
.area 1
    .db     GadoraExitDistance_Left
.endarea
