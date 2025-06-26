; Sector 3 - Bob's Abode
; remove event-based transitions leading to wrecked room state
.org Sector3Doors + 0Ch * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector3Doors + 14h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector3Doors + 2Fh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector3Doors + 30h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector3Doors + 3Fh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh
