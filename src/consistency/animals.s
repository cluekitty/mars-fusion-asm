; Allows Samus to be controlled during the animals event

.org 0803964Eh
.area 08039656h - 0803964Eh, 00
; This section removes a conditional branch of MiscPadAfterInteraction
;   which prevents movement during the animals exiting the enclosure sequence.
.endarea

.org 0804D6B0h
.area 0804D6C2h - 0804D6B0h, 00
; This section removes setting Samus' pose to "Unlocking the habitations Deck"
;   (0x3Bh) in DachoraWaitingForBaby which prevents movement during the animals
;   run-away sequence.
.endarea
