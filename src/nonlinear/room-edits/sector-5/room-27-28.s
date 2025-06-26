; Sector 5 - Kago Roadblock
; TODO: Mark extra room 28 as free space since it is unused in RDV
; remove event-based transition from Save Station Southg
.org Sector5Doors + 2Dh * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea
