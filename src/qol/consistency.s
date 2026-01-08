; Various patches that aim to make RNG parts of the game consistent

; Make delay after animals consistent
; The below changes a conditional branch of MiscPadAfterInteraction so that Samus is free to move 
.org 08039654h
    nop

; The below removes setting Samus pose to 0x3Bh in DachoraWaitingForBaby
.org 0804D6BCh
    nop