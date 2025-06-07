; Main Deck - Main Elevator Shaft
; remove event-based transition
.org MainDeckDoors + 32h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_NoHatch
.endarea
