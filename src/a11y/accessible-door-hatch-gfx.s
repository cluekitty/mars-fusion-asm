; Changes the graphics of the door hatches in order to
; make it possible to differentiate them without color.

.org 083F28C8h  ; Address of common graphics
.area 1000h
    .incbin "data/accessible-doors.gfx"
.endarea