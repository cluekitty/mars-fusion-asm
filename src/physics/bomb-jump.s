; Removes the check for invincibility frames when bomb jumping.
; This fixes an inconsistent behavior when trying to bomb jump in electrified
; water where when samus takes damage, if the invincibility frames have not
; expired when this code is run then samus will not be propelled by the bomb.
.org 080856AAh ; Modifying code in ProjectileCheckSamusBombBounce
.area 080856B2h - 080856AAh, 0
    b       080856B2h
.endarea
