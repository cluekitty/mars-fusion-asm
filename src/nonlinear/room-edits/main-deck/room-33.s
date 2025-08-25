; Main Deck - Silo Scaffolding
; Slightly adjust exit-distance from door with gadora to prevent instant damage if the gadora is not defeated.

.org MainDeckDoors + 75h * DoorEntry_Size + DoorEntry_ExitDistanceX
.area 1
    .db     GadoraExitDistance_Right
.endarea
