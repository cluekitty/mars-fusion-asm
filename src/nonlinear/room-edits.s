; Room edits for open exploration, enemies, softlock prevention, etc.

; TODO: patch scroll behavior such that if no scroll zones are found,
; extended scrolls with unbroken tiles will be treated as fallbacks.

; Debug room data
.defineregion 083C2A48h, 3 * 90h
.defineregion 083C2C10h, 3Ch
.defineregion 083F1548h, 0C56h

; Main Deck Changes
.include "src/nonlinear/room-edits/main-deck/scrolls.s"
.include "src/nonlinear/room-edits/main-deck/room-06.s"
.include "src/nonlinear/room-edits/main-deck/room-0A.s"
.include "src/nonlinear/room-edits/main-deck/room-0D-4A-55.s"
.include "src/nonlinear/room-edits/main-deck/room-12.s"
.include "src/nonlinear/room-edits/main-deck/room-14-and-2E.s"
.include "src/nonlinear/room-edits/main-deck/room-15.s"
.include "src/nonlinear/room-edits/main-deck/room-18.s"
.include "src/nonlinear/room-edits/main-deck/room-22.s"
.include "src/nonlinear/room-edits/main-deck/room-23-24.s"
.include "src/nonlinear/room-edits/main-deck/room-26.s"
.include "src/nonlinear/room-edits/main-deck/room-29-2A.s"
.include "src/nonlinear/room-edits/main-deck/room-30.s"
.include "src/nonlinear/room-edits/main-deck/room-31-3B.s"
.include "src/nonlinear/room-edits/main-deck/room-47.s"
.include "src/nonlinear/room-edits/main-deck/room-52.s"
.include "src/nonlinear/room-edits/main-deck/room-56.s"


; Sector 1 (SRX) Changes
.include "src/nonlinear/room-edits/sector-1/scrolls.s"
.include "src/nonlinear/room-edits/sector-1/room-04.s"
.include "src/nonlinear/room-edits/sector-1/room-0A.s"
.include "src/nonlinear/room-edits/sector-1/room-0C.s"
.include "src/nonlinear/room-edits/sector-1/room-0F.s"
.include "src/nonlinear/room-edits/sector-1/room-14.s"
.include "src/nonlinear/room-edits/sector-1/room-26.s"
.include "src/nonlinear/room-edits/sector-1/room-2E.s"

; Sector 2 (TRO) Changes
.include "src/nonlinear/room-edits/sector-2/room-03.s"
.include "src/nonlinear/room-edits/sector-2/room-07-and-1F.s"
.include "src/nonlinear/room-edits/sector-2/room-09.s"
.include "src/nonlinear/room-edits/sector-2/room-0A.s"
.include "src/nonlinear/room-edits/sector-2/room-0C.s"
.include "src/nonlinear/room-edits/sector-2/room-0D-2E.s"
.include "src/nonlinear/room-edits/sector-2/room-0E.s"
.include "src/nonlinear/room-edits/sector-2/room-11.s"
.include "src/nonlinear/room-edits/sector-2/room-1B.s"
.include "src/nonlinear/room-edits/sector-2/room-20-and-23.s"
.include "src/nonlinear/room-edits/sector-2/room-32.s"
.include "src/nonlinear/room-edits/sector-2/room-36.s"
.include "src/nonlinear/room-edits/sector-2/room-39.s"

; Sector 2 - Owtch Cache A
; TODO: fix screen scroll when custom start is behind bomb blocks


; Sector 3 - Security Access
; remove sidehoppers on speedbooster runway to prevent near softlock with neither charge nor missiles
; move sidehoppers below runway to prevent them from clipping into the wall
.org readptr(Sector3Levels + 03h * LevelMeta_Size + LevelMeta_Spriteset1)
.area 27h
    .db     04h, 24h, 0A4h
    .db     05h, 1Fh, 0A4h
    .db     05h, 29h, 0A4h
    .db     06h, 1Dh, 02h
    .db     14h, 29h, 23h
    .db     14h, 2Ch, 23h
    .db     0FFh, 0FFh, 0FFh
.endarea

; Sector 3 - Bob's Room
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

; Sector 3 - BOX Access
; repair door to bob's room
.defineregion readptr(Sector3Levels + 16h * LevelMeta_Size + LevelMeta_Clipdata), 0A5h

.org readptr(Sector3Levels + 16h * LevelMeta_Size + LevelMeta_Bg1)
.area 300h
.incbin "data/rooms/S3-16-BG1.rlebg"
.endarea

.autoregion
@S3_BoxAccess_Clipdata:
.incbin "data/rooms/S3-16-Clip.rlebg"
.endautoregion

.org Sector3Levels + 16h * LevelMeta_Size + LevelMeta_Clipdata
.area 04h
    .dw     @S3_BoxAccess_Clipdata
.endarea

.org Sector3Doors + 10h * DoorEntry_Size + DoorEntry_SourceRoom
.area 1
    .db     16h
.endarea

.org Sector3Doors + 23h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

; Sector 3 - BOX Arena
; repair door to data room
.defineregion readptr(Sector3Levels + 17h * LevelMeta_Size + LevelMeta_Clipdata), 08Fh

.org readptr(Sector3Levels + 17h * LevelMeta_Size + LevelMeta_Bg1)
.area 256h
.incbin "data/rooms/S3-17-BG1.rlebg"
.endarea

.autoregion
@S3_BoxArena_Clipdata:
.incbin "data/rooms/S3-17-Clip.rlebg"
.endautoregion

.org Sector3Levels + 17h * LevelMeta_Size + LevelMeta_Clipdata
.area 04h
    .dw     @S3_BoxArena_Clipdata
.endarea

.org Sector3Doors + 1Dh * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector3Doors + 2Bh * DoorEntry_Size + DoorEntry_SourceRoom
.area 1
    .db     17h
.endarea

.org Sector3Doors + 2Dh * DoorEntry_Size + DoorEntry_Type
.area DoorEntry_Destination - DoorEntry_Type + 1
    .db     DoorType_LockableHatch
    .skip DoorEntry_Destination - DoorEntry_Type - 1
    .db     2Eh
.endarea

.org Sector3Doors + 24h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

; Extends upper scroll down by one tile for slightly better visibility after
; defeating BOX without showing the exit during the fight
.org readptr(Sector3Scrolls + 09h * 4) + ScrollList_HeaderSize
.area Scroll_Size
    .db     10h, 1Fh
    .db     02h, 0Dh
    .db     0FFh, 0FFh
    .db     ScrollExtend_None
    .db     0FFh
.endarea

; Sector 4 - Serris Escape
; TODO: fix screen scrolls when custom start is behind the bomb blocks
; scroll 0 (11, 02) -> (2E, 17), scroll 1 (02, 16) -> (2E, 1F)

; Sector 4 - Pump Control Access
; fix screen scrolls when entering from Pump Control Save Room
.org readptr(Sector4Scrolls + 03h * 4) + ScrollList_HeaderSize
.area Scroll_Size
    .db     02h, 10h
    .db     02h, 29h
    .db     0FFh, 0FFh
    .db     ScrollExtend_None
    .db     0FFh
.endarea

; Sector 4 - Pump Control Save Room
; fix entering the room for the first time from morph tunnel
; this should only be an issue for entrance rando
.org Sector4Doors + 045h * DoorEntry_Size + DoorEntry_ExitDistanceX
.area 1
    .db 0E0h
.endarea

; Sector 4 - Cheddar Bay
; fix screen scrolls when entering from Security Bypass
.org readptr(Sector4Scrolls + 05h * 4) + ScrollList_HeaderSize + Scroll_Size * 1
.area Scroll_Size
    .db     02h, 20h
    .db     02h, 0Ch
    .db     0FFh, 0FFh
    .db     ScrollExtend_None
    .db     0FFh
.endarea

; Sector 4 - Waterway
; add flooded room state
.autoregion
@S4_Waterway_Spriteset0:
    .db     03h, 09h, 17h
    .db     03h, 0Bh, 17h
    .db     03h, 10h, 17h
    .db     03h, 13h, 17h
    .db     03h, 17h, 17h
    .db     04h, 08h, 12h
    .db     04h, 18h, 12h
    .db     07h, 10h, 11h
    .db     0FFh, 0FFh, 0FFh
.endautoregion

.org Sector4Levels + 1Ch * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_Spriteset2Event - LevelMeta_Spriteset0
    .dw     @S4_Waterway_Spriteset0
    .db     0Eh
    .db     Event_WaterLevelLowered
    .skip 2
    .dw     readptr(Sector4Levels + 1Ch * LevelMeta_Size + LevelMeta_Spriteset0)
    .db     1Dh
.endarea

; Sector 4 - Security Bypass
; prevent several softlocks without bombs
.if ANTI_SOFTLOCK
.org readptr(Sector4Levels + 22h * LevelMeta_Size + LevelMeta_Bg1)
.area 57Ah
.incbin "data/rooms/S4-22-BG1.rlebg"
.endarea

.org readptr(Sector4Levels + 22h * LevelMeta_Size + LevelMeta_Clipdata)
.area 1B1h
.incbin "data/rooms/S4-22-Clip.rlebg"
.endarea
.endif

; Sector 4 - Drain Pipe
; keep puffer always active
.defineregion readptr(Sector4Levels + 24h * LevelMeta_Size + LevelMeta_Spriteset1), 2Ah

.org Sector4Levels + 24h * LevelMeta_Size + LevelMeta_Spriteset1Event
.area LevelMeta_MapX - LevelMeta_Spriteset1Event
    .db     Event_WaterLevelLowered
    .skip 2
    .dw     readptr(Sector4Levels + 24h * LevelMeta_Size + LevelMeta_Spriteset2)
    .db     23h
    .db     0
    .skip 2
    .dw     NullSpriteset
    .db     0
.endarea

; Sector 4 - Aquarium Storage
; make kago always block missile tank
.defineregion readptr(Sector4Levels + 26h * LevelMeta_Size + LevelMeta_Spriteset0), 24h

.org Sector4Levels + 26h * LevelMeta_Size + LevelMeta_Spriteset0
.area LevelMeta_Spriteset2Event - LevelMeta_Spriteset0
    .dw     readptr(Sector4Levels + 26h * LevelMeta_Size + LevelMeta_Spriteset1)
    .skip 1
    .db     0
    .skip 2
    .dw     NullSpriteset
    .db     0
.endarea

; Sector 5 - Nightmare Training Grounds
; restructure the room to have a speedbooster runway across the top
; add speedbooster blocks above the power bomb blocks
.defineregion readptr(Sector5Levels + 03h * LevelMeta_Size + LevelMeta_Bg1), 486h
.defineregion readptr(Sector5Levels + 03h * LevelMeta_Size + LevelMeta_Clipdata), 212h

.autoregion
@S5_NightmareTrainingGrounds_Bg1:
.incbin "data/rooms/S5-03-BG1.rlebg"
.endautoregion

.autoregion
@S5_NightmareTrainingGrounds_Clipdata:
.incbin "data/rooms/S5-03-Clip.rlebg"
.endautoregion

; Remove Nightmare flying around by removing BG0
.org Sector5Levels + 03h * LevelMeta_Size + LevelMeta_Bg0Properties
    .db     0
.org Sector5Levels + 03h * LevelMeta_Size + LevelMeta_Bg0
    .dw     NullBg

.org Sector5Levels + 03h * LevelMeta_Size + LevelMeta_Bg1
.area 0Ch
    .dw     @S5_NightmareTrainingGrounds_Bg1
    .skip 4
    .dw     @S5_NightmareTrainingGrounds_Clipdata
.endarea

.org readptr(Sector5Levels + 03h * LevelMeta_Size + LevelMeta_Spriteset0)
.area 06h
    .db     10h, 1Ch, 25h
    .db     10h, 23h, 25h
.endarea

.org Sector5Doors + 03h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector5Doors + 0Ah * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector5Doors + 4Dh * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector5Doors + 0Bh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 0Ch * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 0Dh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 50h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

; Sector 5 - Arctic Containment
; change the lv4 security door to crow's nest to a functional lv3 security door
.defineregion readptr(Sector5Levels + 07h * LevelMeta_Size + LevelMeta_Clipdata), 1AAh

.org readptr(Sector5Levels + 07h * LevelMeta_Size + LevelMeta_Bg1)
.area 652h
.incbin "data/rooms/S5-07-BG1.rlebg"
.endarea

.autoregion
@S5_ArcticContainment_Clipdata:
.incbin "data/rooms/S5-07-Clip.rlebg"
.endautoregion

.org Sector5Levels + 07h * LevelMeta_Size + LevelMeta_Clipdata
.area 04h
    .dw     @S5_ArcticContainment_Clipdata
.endarea

.org Sector5Doors + 15h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector5Doors + 24h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector5Doors + 35h * DoorEntry_Size + DoorEntry_Type
.area DoorEntry_ExitDistanceX - DoorEntry_Type + 1
    .db     DoorType_LockableHatch
    .db     07h
    .skip DoorEntry_ExitDistanceX - DoorEntry_SourceRoom - 1
    .db     -20h
.endarea

.org Sector5Doors + 38h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_OpenHatch
.endarea

.org Sector5Doors + 55h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector5Doors + 64h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

.org Sector5Doors + 1Bh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 1Ch * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 1Dh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 1Fh * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 39h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.org Sector5Doors + 46h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

.if RANDOMIZER
; Sector 5 - Geron Checkpoint
; Remove power bomb geron spriteset
.defineregion readptr(Sector5Levels + 08h * LevelMeta_Size + LevelMeta_Spriteset2), 15h
.org Sector5Levels + 08h * LevelMeta_Size + LevelMeta_Spriteset2Event
.area LevelMeta_Spriteset2Id - LevelMeta_Spriteset1Id
    .db     0
    .skip   2
    .dw     NullSpriteset
    .db     0
.endarea
.endif

; Sector 5 - Frozen Tower
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

; Sector 5 - Data Room
; merge the intact and destroyed data rooms into a single room
; seal off the destroyed upper half of the data room from the intact lower half
.defineregion readptr(Sector5Levels + 10h * LevelMeta_Size + LevelMeta_Clipdata), 84h

.org readptr(Sector5Levels + 10h * LevelMeta_Size + LevelMeta_Bg1)
.area 19Fh
.incbin "data/rooms/S5-10-BG1.rlebg"
.endarea

.autoregion
@S5_DataRoom_Clipdata:
.incbin "data/rooms/S5-10-Clip.rlebg"
.endautoregion

.org Sector5Levels + 10h * LevelMeta_Size + LevelMeta_Clipdata
.area 04h
    .dw     @S5_DataRoom_Clipdata
.endarea

.org readptr(Sector5Levels + 10h * LevelMeta_Size + LevelMeta_Spriteset0)
.area 03h
    .db     14h, 09h, 11h
.endarea

.org Sector5Levels + 10h * LevelMeta_Size + LevelMeta_Spriteset0Id
.area 01h
    .db     0Ch
.endarea

.org Sector5Doors + 56h * DoorEntry_Size + DoorEntry_Type
.area DoorEntry_Destination - DoorEntry_Type + 1
    .db     DoorType_LockableHatch
    .skip DoorEntry_Destination - DoorEntry_Type - 1
    .db     5Ch
.endarea

.org Sector5Doors + 59h * DoorEntry_Size + DoorEntry_SourceRoom
.area DoorEntry_YEnd - DoorEntry_SourceRoom + 1
    .db     10h
    .db     10h, 10h
    .db     0Fh, 12h
.endarea

.org Sector5Doors + 34h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

; Sector 5 - Security Shaft East
; repair the door to kago blockade
.defineregion readptr(Sector5Levels + 16h * LevelMeta_Size + LevelMeta_Clipdata), 110h

.org readptr(Sector5Levels + 16h * LevelMeta_Size + LevelMeta_Bg1)
.area 2EBh
.incbin "data/rooms/S5-16-BG1.rlebg"
.endarea

.autoregion
@S5_SecurityShaftEast_Clipdata:
.incbin "data/rooms/S5-16-Clip.rlebg"
.endautoregion

.org Sector5Levels + 16h * LevelMeta_Size + LevelMeta_Clipdata
.area 04h
    .dw     @S5_SecurityShaftEast_Clipdata
.endarea

.org Sector5Doors + 28h * DoorEntry_Size + DoorEntry_Type
.area DoorEntry_Destination - DoorEntry_Type + 1
    .db     DoorType_LockableHatch
    .skip DoorEntry_Destination - DoorEntry_Type - 1
    .db     6Ch
.endarea

.org Sector5Doors + 2Ah * DoorEntry_Size + DoorEntry_SourceRoom
.area 1
    .db     16h
.endarea

.org Sector5Doors + 29h * DoorEntry_Size
.fill DoorEntry_Size, 0FFh

; Sector 5 - Ripper Road
; replace lv0 door to arctic containment with an open hatch
.org readptr(Sector5Levels + 1Ah * LevelMeta_Size + LevelMeta_Bg1)
.area 1B3h
.incbin "data/rooms/S5-1A-BG1.rlebg"
.endarea

.org readptr(Sector5Levels + 1Ah * LevelMeta_Size + LevelMeta_Clipdata)
.area 0A4h
.incbin "data/rooms/S5-1A-Clip.rlebg"
.endarea

.org Sector5Doors + 37h * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_OpenHatch
.endarea

; Sector 5 - Crow's Nest
; repair the door to arctic containment into a lv3 security door
.defineregion readptr(Sector5Levels + 24h * LevelMeta_Size + LevelMeta_Clipdata), 0F0h

.org readptr(Sector5Levels + 24h * LevelMeta_Size + LevelMeta_Bg1)
.area 263h
.incbin "data/rooms/S5-24-BG1.rlebg"
.endarea

.autoregion
@S5_CrowsNest_Clipdata:
.incbin "data/rooms/S5-24-Clip.rlebg"
.endautoregion

.org Sector5Levels + 24h * LevelMeta_Size + LevelMeta_Clipdata
.area 04h
    .dw     @S5_CrowsNest_Clipdata
.endarea

.org Sector5Doors + 57h * DoorEntry_Size + DoorEntry_Type
.area DoorEntry_ExitDistanceX - DoorEntry_Type + 1
    .db     DoorType_LockableHatch
    .skip DoorEntry_ExitDistanceX - DoorEntry_Type - 1
    .db     20h
.endarea

; Sector 5 - Kago Blockade
; remove event-based transition from Save Station South
.org Sector5Doors + 2Dh * DoorEntry_Size + DoorEntry_Type
.area 1
    .db     DoorType_LockableHatch
.endarea

; Sector 5 - Groznyj Grad
; fix screen scrolls when entering from Security Shaft East
.defineregion readptr(Sector5Scrolls + 0Fh * 4), ScrollList_HeaderSize + Scroll_Size * 1

; Sector 5 scroll table fixes
.org Sector5Scrolls
.area 4Ch
    .dw     readptr(Sector5Scrolls + 00h * 4)
    .dw     readptr(Sector5Scrolls + 01h * 4)
    .dw     readptr(Sector5Scrolls + 02h * 4)
    .dw     readptr(Sector5Scrolls + 03h * 4)
    .dw     readptr(Sector5Scrolls + 04h * 4)
    .dw     readptr(Sector5Scrolls + 05h * 4)
    .dw     readptr(Sector5Scrolls + 06h * 4)
    .dw     readptr(Sector5Scrolls + 07h * 4)
    .dw     readptr(Sector5Scrolls + 08h * 4)
    .dw     readptr(Sector5Scrolls + 09h * 4)
    .dw     readptr(Sector5Scrolls + 0Ah * 4)
    .dw     readptr(Sector5Scrolls + 0Bh * 4)
    .dw     readptr(Sector5Scrolls + 0Ch * 4)
    .dw     readptr(Sector5Scrolls + 0Dh * 4)
    .dw     readptr(Sector5Scrolls + 0Eh * 4)
    .dw     readptr(Sector5Scrolls + 10h * 4)
    .dw     readptr(Sector5Scrolls + 11h * 4)
    .dw     readptr(Sector5Scrolls + 12h * 4)
.endarea

; Sector 6 - Zozoro Wine Cellar
; change the reforming bomb block to a never reforming bomb block to prevent
; softlocking from running out of power bombs
.if ANTI_SOFTLOCK
.org readptr(Sector6Levels + 0Fh * LevelMeta_Size + LevelMeta_Clipdata)
.area 033h
.incbin "data/rooms/S6-0F-Clip.rlebg"
.endarea
.endif

; Sector 6 - X-BOX Arena
; change the top crumble block into a shot block to mitigate accidentally
; entering a point of no return
.org readptr(Sector6Levels + 10h * LevelMeta_Size + LevelMeta_Clipdata)
.area 0B3h
.incbin "data/rooms/S6-10-Clip.rlebg"
.endarea

; Sector 6 - Forbidden Entrance
; fix screen scrolls when entering room from XBOX Access
.defineregion readptr(Sector6Scrolls + 02h * 4), ScrollList_HeaderSize + Scroll_Size * 1

; Sector 6 - Missile Storage
; TODO: fix screen scrolls when custom start is behind bomb blocks

; Sector 6 - Big Shell 2
; fix screen scrolls when entering room from Blue X Blockade
.defineregion readptr(Sector6Scrolls + 0Fh * 4), ScrollList_HeaderSize + Scroll_Size * 1

; Sector 6 scroll table fixes
.org Sector6Scrolls
.area 50h
    .dw     readptr(Sector6Scrolls + 00h * 4)
    .dw     readptr(Sector6Scrolls + 01h * 4)
    .dw     readptr(Sector6Scrolls + 03h * 4)
    .dw     readptr(Sector6Scrolls + 04h * 4)
    .dw     readptr(Sector6Scrolls + 05h * 4)
    .dw     readptr(Sector6Scrolls + 06h * 4)
    .dw     readptr(Sector6Scrolls + 07h * 4)
    .dw     readptr(Sector6Scrolls + 08h * 4)
    .dw     readptr(Sector6Scrolls + 09h * 4)
    .dw     readptr(Sector6Scrolls + 0Ah * 4)
    .dw     readptr(Sector6Scrolls + 0Bh * 4)
    .dw     readptr(Sector6Scrolls + 0Ch * 4)
    .dw     readptr(Sector6Scrolls + 0Dh * 4)
    .dw     readptr(Sector6Scrolls + 0Eh * 4)
    .dw     readptr(Sector6Scrolls + 10h * 4)
    .dw     readptr(Sector6Scrolls + 11h * 4)
    .dw     readptr(Sector6Scrolls + 12h * 4)
    .dw     readptr(Sector6Scrolls + 13h * 4)
.endarea



.include "src/nonlinear/room-edits/sector-4/room-06.s"
.include "src/nonlinear/room-edits/sector-4/room-23.s"
.include "src/nonlinear/room-edits/sector-6/room-1B.s"
