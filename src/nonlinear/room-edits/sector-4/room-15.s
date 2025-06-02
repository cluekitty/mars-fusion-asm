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
