; Sector 2 - Zazabi Arena
; fix screen scroll when entering room from Zazabi Speedway
.org readptr(Sector2Scrolls + 05h * 4) + ScrollList_HeaderSize
.area Scroll_Size
    .db     02h, 2Eh
    .db     02h, 0Eh
    .db     0FFh, 0FFh
    .db     ScrollExtend_None
    .db     0FFh
.endarea
