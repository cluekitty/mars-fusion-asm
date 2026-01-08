; Allows Samus to be controlled during the animals event

; The below removes a conditional branch of MiscPadAfterInteraction 
; which prevents movement during the animals exiting the enclosure sequence
.org 08039654h
    nop

; The below removes setting Samus' pose to "Unlocking the habitations Deck" (0x3Bh) in DachoraWaitingForBaby 
; which prevents movement during the animals run-away sequence
.org 0804D6BCh
    nop
