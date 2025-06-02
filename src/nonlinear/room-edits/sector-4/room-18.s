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
