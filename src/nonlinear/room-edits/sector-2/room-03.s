; Sector 2 - Courtyard Access
; move cocoon and kihunter spritesets to intact room state
.org Sector2Levels + 03h * LevelMeta_Size + LevelMeta_Spriteset1Event
.area LevelMeta_MapX - LevelMeta_Spriteset1Event
    .db     Event_ZazabiAbsorbed
    .skip 2
    .dw     readptr(Sector2Levels + 1Eh * LevelMeta_Size + LevelMeta_Spriteset0)
    .db     13h
    .db     Event_ReactorOutage
    .skip 2
    .dw     readptr(Sector2Levels + 1Eh * LevelMeta_Size + LevelMeta_Spriteset1)
    .db     1Eh
.endarea

.org Sector2Doors + 02h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea
