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


; Sector 3 (PYR) Changes
.include "src/nonlinear/room-edits/sector-3/room-03.s"
.include "src/nonlinear/room-edits/sector-3/room-06-18.s"
.include "src/nonlinear/room-edits/sector-3/room-07-16.s"
.include "src/nonlinear/room-edits/sector-3/room-12-17.s"


; Sector 4 (AQA) Changes
.include "src/nonlinear/room-edits/sector-4/room-06.s"
.include "src/nonlinear/room-edits/sector-4/room-0D.s"
.include "src/nonlinear/room-edits/sector-4/room-15.s"
.include "src/nonlinear/room-edits/sector-4/room-16.s"
.include "src/nonlinear/room-edits/sector-4/room-18.s"
.include "src/nonlinear/room-edits/sector-4/room-1C.s"
.include "src/nonlinear/room-edits/sector-4/room-22.s"
.include "src/nonlinear/room-edits/sector-4/room-23.s"
.include "src/nonlinear/room-edits/sector-4/room-24.s"
.include "src/nonlinear/room-edits/sector-4/room-26.s"


; Sector 5 (ARC) Changes
.include "src/nonlinear/room-edits/sector-5/scrolls.s"
.include "src/nonlinear/room-edits/sector-5/room-03-06.s"
.include "src/nonlinear/room-edits/sector-5/room-05-10.s"
.include "src/nonlinear/room-edits/sector-5/room-07-0F.s"
.include "src/nonlinear/room-edits/sector-5/room-08.s"
.include "src/nonlinear/room-edits/sector-5/room-0D-2C.s"
.include "src/nonlinear/room-edits/sector-5/room-15-16.s"
.include "src/nonlinear/room-edits/sector-5/room-1A.s"
.include "src/nonlinear/room-edits/sector-5/room-24.s"
.include "src/nonlinear/room-edits/sector-5/room-27-28.s"
.include "src/nonlinear/room-edits/sector-5/room-2B.s"


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



.include "src/nonlinear/room-edits/sector-6/room-1B.s"
