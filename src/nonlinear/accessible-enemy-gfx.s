; Changes the graphics of some enemies in order to
; differentiate them with similar looking enemies.
; Done for accessibility reasons.
; E.g. colorblind people may have issues in vanilla
; distinguishing red and blue zoros.


; Blue/Stronger Zoro - adds holes
.org 0833B614h
.area 0800h
    .incbin "data/enemies/strong-zoro-holes.gfx"
.endarea

; Red/Stronger Zeela - adds straw eyes and removes teeth
.org 083506BCh
.area 01000h
    .incbin "data/enemies/strong-zeela-straw-eyes-no-teeth.gfx"
.endarea

; Super Missile Geron - adds spikes
.org 0835FD0Ch
.area 0800h
    .incbin "data/enemies/super-missile-geron-spikes.gfx"
.endarea

; Golden/Stronger Scizer - removes shell
.org 08319118h
.area 01000h
    .incbin "data/enemies/gold-crab-no-shell.gfx"
.endarea

; Golden/Strongest Pirate - adds mohawk
.org 0835C3F0h
.area 01800h
    .incbin "data/enemies/gold-pirate-mohawk.gfx"
.endarea
