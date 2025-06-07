; Main Deck - Main Elevator Access
; remove event-based transition
.org MainDeckDoors + 4Ah * DoorEntry_Size + DoorEntry_Type
.area DoorEntry_Destination - DoorEntry_Type + 1
    .db     DoorType_LockableHatch
    .skip DoorEntry_Destination - DoorEntry_Type - 1
    .db     61h
.endarea

.org MainDeckDoors + 5Ch * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org MainDeckDoors + 5Dh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh
