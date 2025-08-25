; Sector 3 - Main Boiler
; Slightly adjust exit-distance from door with gadora to prevent instant damage if the gadora is not defeated.

.org Sector3Doors + 31h * DoorEntry_Size + DoorEntry_ExitDistanceX
.area 1
    .db     GadoraExitDistance_Right
.endarea
