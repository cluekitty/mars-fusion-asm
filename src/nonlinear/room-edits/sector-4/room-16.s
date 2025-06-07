; Sector 4 - Pump Control Save Room
; fix entering the room for the first time from morph tunnel
; this should only be an issue for entrance rando
.org Sector4Doors + 045h * DoorEntry_Size + DoorEntry_ExitDistanceX
.area 1
    .db 0E0h
.endarea
