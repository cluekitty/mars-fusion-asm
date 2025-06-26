; Sector 1 - Sciser Playground
; fix screen scroll when entering room from Charge Core Access
.defineregion readptr(Sector1Scrolls + 07h * 4), ScrollList_HeaderSize + Scroll_Size * 1
