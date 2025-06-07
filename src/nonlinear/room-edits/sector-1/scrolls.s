; Sector 1 scroll table fixes
.org Sector1Scrolls
.area 30h
    .dw     readptr(Sector1Scrolls + 00h * 4)
    .dw     readptr(Sector1Scrolls + 02h * 4)
    .dw     readptr(Sector1Scrolls + 03h * 4)
    .dw     readptr(Sector1Scrolls + 04h * 4)
    .dw     readptr(Sector1Scrolls + 05h * 4)
    .dw     readptr(Sector1Scrolls + 06h * 4)
    .dw     readptr(Sector1Scrolls + 08h * 4)
    .dw     readptr(Sector1Scrolls + 09h * 4)
    .dw     readptr(Sector1Scrolls + 0Ah * 4)
    .dw     readptr(Sector1Scrolls + 0Bh * 4)
.endarea
