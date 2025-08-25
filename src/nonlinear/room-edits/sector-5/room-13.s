; Sector 5 - Nightmare Upper Access
; Slightly adjust exit-distance from door with gadora to prevent instant damage if the gadora is not defeated.

.org Sector5Doors + 26h * DoorEntry_Size + DoorEntry_ExitDistanceX
.area 1
    .db     GadoraExitDistance_Left
.endarea
