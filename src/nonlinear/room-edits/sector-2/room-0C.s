; Sector 2 - Shooting Gallery
; change lower door connection to be event based
.org VariableConnections + (0Bh * VariableConnection_Size)
.area 4
    .db Area_TRO, 19h
    .db Event_NettoriAbsorbed, 4Bh
.endarea

.org Sector2Doors + 19h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db 24h
.endarea

.org Sector2Doors + 19h * DoorEntry_Size + DoorEntry_Destination
.area 1
    .db 2Fh
.endarea
