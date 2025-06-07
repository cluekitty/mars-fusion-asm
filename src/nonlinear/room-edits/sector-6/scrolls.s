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
