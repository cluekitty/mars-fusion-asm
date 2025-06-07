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
