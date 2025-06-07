; Sector 5 - Frozen Tower
;TODO: Remove room 2C as it is unused in RDV

; remove event-based transitions
.org Sector5Doors + 17h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector5Doors + 2Fh * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_NoHatch
.endarea

.org Sector5Doors + 30h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector5Doors + 5Eh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 5Fh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 60h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh
