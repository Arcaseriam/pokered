 ; CHANGE
InitCustomStarter:
	push af
	push hl

	ld a, 129 ; Default alphabetical-ordered starter ID ; Squirtle
	ld [wCustomStarterAlphabeticalID], a
	call SetCustomStarterInternalID
	ld a, $f
	ld hl, wCustomStarterAtkDV
	ld [hli], a ; Atk
	ld [hli], a ; Def
	ld [hli], a ; Spe
	ld [hl], a  ; Spc
	xor a
	set 1, a
	ld [wCustomStarterPosition], a
	ld a, STARTER1
	ld [wCustomStarter1], a
	ld a, [wCustomStarterInternalID]
	ld [wCustomStarter2], a
	ld a, STARTER3
	ld [wCustomStarter3], a
	ld a, 7
	ld [wCustomStarterPositionX], a

	pop hl
	pop af
	ret