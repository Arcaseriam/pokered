; CHANGE
DisplayStarterMenu:
	hlcoord 0, 0
	ld b, 3
	ld c, 18
	call TextBoxBorder
	hlcoord 0, 4
	ld b, 6
	ld c, 18
	call TextBoxBorder
	hlcoord 0, 11
	ld b, 3
	ld c, 18
	call TextBoxBorder
	hlcoord 1, 1
	ld de, StarterSpeciesText
	call PlaceString
	hlcoord 1, 3
	ld de, StarterSpeciesHoldtext
	call PlaceString
	hlcoord 1, 5
	ld de, StarterDVsText
	call PlaceString
	hlcoord 1, 6
	ld de, StarterAtkText
	call PlaceString
	hlcoord 1, 7
	ld de, StarterDefText
	call PlaceString
	hlcoord 1, 8
	ld de, StarterSpeText
	call PlaceString
	hlcoord 1, 9
	ld de, StarterSpcText
	call PlaceString
	hlcoord 1, 12
	ld de, StarterBallText
	call PlaceString
	hlcoord 1, 13
	ld de, StarterBallChoiceText
	call PlaceString
	hlcoord 2, 16
	ld de, StarterCancelText
	call PlaceString
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	inc a
	ld [wLetterPrintingDelayFlags], a
	call SetCursorPositionsFromCustomStarter
	call StarterNameDisplay
	call StarterDVsDisplay
	ld a, 1
	ld [wTopMenuItemX], a
	ld a, 2
	ld [wTopMenuItemY], a
	ld a, 1 
	ldh [hJoy7], a
	ldh [hJoy6], a ; Set Mode 2 of JoypadLowSensitivity (faster Starter selection)
	ld a, $01
	ldh [hAutoBGTransferEnabled], a ; enable auto background transfer
	call Delay3
.loop
	call PlaceMenuCursor
	;call SetOptionsFromCursorPositions
.getJoypadStateLoop
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	ld b, a
	and A_BUTTON | B_BUTTON | START | D_RIGHT | D_LEFT | D_UP | D_DOWN ; any key besides select pressed?
	jr z, .getJoypadStateLoop
	bit 1, b ; B button pressed?
	jr nz, .exitMenu
	bit 3, b ; Start button pressed?
	jr nz, .exitMenu
	bit 0, b ; A button pressed?
	jr z, .checkDirectionKeys
	ld a, [wTopMenuItemY]
	cp 16 ; is the cursor on Cancel?
	jr nz, .loop
.exitMenu
	;ld a, SFX_PRESS_AB
	;call PlaySound
	ret
.eraseOldMenuCursor
	ld [wTopMenuItemX], a
	call EraseMenuCursor
	jp .loop
.checkDirectionKeys
	ld a, [wTopMenuItemY]
	bit 7, b ; Down pressed?
	jr nz, .downPressed
	bit 6, b ; Up pressed?
	jr nz, .upPressed
	cp 6 ; cursor in Atk?
	jp z, .cursorInAtk
	cp 7 ; cursor in Def?
	jp z, .cursorInDef
	cp 8 ; cursor in Spe?
	jp z, .cursorInSpe
	cp 9 ; cursor in Spc?
	jp z, .cursorInSpc
	cp 13 ; cursor in position ?
	jp z, .cursorInPosition
	cp 16 ; cursor on Cancel?
	jr z, .loop
.cursorInSpecies
	bit 5, b ; Left pressed?
	jp nz, .pressedLeftInSpecies
	jp .pressedRightInSpecies
.downPressed
	ld a, 1
	ld [wTopMenuItemX], a
	ld a, [wTopMenuItemY]
	ld hl, wTopMenuItemX
	cp 16 ; on Cancel ?
	ld b, -14
	jr z, .updateMenuVariables
	cp 2 ; on Species ?
	ld b, 4
	jr z, .updateMenuVariables
	cp 6 ; on Atk ?
	ld b, 1
	jr z, .updateMenuVariables
	cp 7 ; on Def ?
	ld b, 1
	jr z, .updateMenuVariables
	cp 8 ; on Spe ?
	ld b, 1
	jr z, .updateMenuVariables
	cp 13 ; on Ball ?
	ld b, 3
	jr z, .updateMenuVariables
	cp 9 ; on Spc ?
	jp nz, .loop
	ld hl, wCustomStarterPositionX
	ld b, 4
	jr .updateMenuVariables
.upPressed
	ld a, 1
	ld [wTopMenuItemX], a
	ld a, [wTopMenuItemY]
	ld hl, wTopMenuItemX
	cp 13 ; on Ball ?
	ld b, -4
	jr z, .updateMenuVariables
	cp 9 ; on Spc ?
	ld b, -1
	jr z, .updateMenuVariables
	cp 8 ; on Spe ?
	ld b, -1
	jr z, .updateMenuVariables
	cp 7 ; on Def ?
	ld b, -1
	jr z, .updateMenuVariables
	cp 6 ; on Atk ?
	ld b, -4
	jr z, .updateMenuVariables
	cp 2 ; on Species ?
	ld b, 14
	jr z, .updateMenuVariables
	cp 16 ; on Cancel ?
	jp nz, .loop
	ld hl, wCustomStarterPositionX
	ld b, -3
	;jr .updateMenuVariables
.updateMenuVariables
	add b
	ld [wTopMenuItemY], a
	ld a, [hl]
	ld [wTopMenuItemX], a
	call PlaceUnfilledArrowMenuCursor
	jp .loop

.cursorInAtk
	ld hl, wCustomStarterAtkDV
	jr .DVfallthrough
.cursorInDef
	ld hl, wCustomStarterDefDV
	jr .DVfallthrough
.cursorInSpe
	ld hl, wCustomStarterSpeDV
	jr .DVfallthrough
.cursorInSpc
	ld hl, wCustomStarterSpcDV
.DVfallthrough
	ld a, [hl]
	bit 5, b ; Left pressed?
	jp nz, .decreaseDV
	jp .increaseDV
.decreaseDV
	dec a
	cp 16
	jr c, .updateDV
	xor a ; handles underflow case
	jp .updateDV
.increaseDV
	inc a
	cp 16
	jr c, .updateDV
	ld a, 15 ; handles overflow case
.updateDV
	ld [hl], a
	call StarterDVsDisplay ; overkill, but that will do
	jp .loop
	
.pressedLeftInSpecies
	ld a, [wCustomStarterAlphabeticalID]
	dec a
	cp 151
	jr c, .updateStarterName
	ld a, 150 ; handles underflow case
	jr .updateStarterName
.pressedRightInSpecies
	ld a, [wCustomStarterAlphabeticalID]
	inc a
	cp 151
	jp c, .updateStarterName
	xor a ; handles overflow case
.updateStarterName
	ld [wCustomStarterAlphabeticalID], a
	call StarterNameDisplay
	ld a, STARTER1
	ld [wCustomStarter1], a
	ld a, STARTER2
	ld [wCustomStarter2], a
	ld a, STARTER3
	ld [wCustomStarter3], a
	ld a, [wCustomStarterPosition]
	bit 0, a
	jr nz, .updateStarter1
	bit 1, a
	jr nz, .updateStarter2
.updateStarter3
	ld a, [wCustomStarterInternalID]
	ld [wCustomStarter3], a
	jp .loop
.updateStarter2
	ld a, [wCustomStarterInternalID]
	ld [wCustomStarter2], a
	jp .loop
.updateStarter1
	ld a, [wCustomStarterInternalID]
	ld [wCustomStarter1], a
	jp .loop

.cursorInPosition
	ld a, [wTopMenuItemX]
	bit 5, b ; Left pressed?
	jp nz, .pressedLeftInPosition
	jp .pressedRightInPosition
.pressedLeftInPosition
	cp 12
	jp z, .setMidPosition
	cp 7
	jp z, .setLeftPosition
	jp .loop
.pressedRightInPosition
	cp 1
	jp z, .setMidPosition
	cp 7
	jp z, .setRightPosition
	jp .loop
.setLeftPosition
	xor a
	set 0, a
	ld [wCustomStarterPosition], a
	ld a, [wCustomStarterInternalID]
	ld [wCustomStarter1], a
	ld a, STARTER2
	ld [wCustomStarter2], a
	ld a, STARTER3
	ld [wCustomStarter3], a
	ld a, 1
	ld [wTopMenuItemX], a
	ld [wCustomStarterPositionX], a
	call SetCursorPositionsFromCustomStarter ; overkill, i know
	ld a, [wCustomStarterPositionX]
	jr .done
.setMidPosition
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
	ld [wTopMenuItemX], a
	ld [wCustomStarterPositionX], a
	call SetCursorPositionsFromCustomStarter ; overkill, i know
	ld a, [wCustomStarterPositionX]
	jr .done
.setRightPosition
	xor a
	set 2, a
	ld [wCustomStarterPosition], a
	ld a, STARTER1
	ld [wCustomStarter1], a
	ld a, STARTER2
	ld [wCustomStarter2], a
	ld a, [wCustomStarterInternalID]
	ld [wCustomStarter3], a
	ld a, 12
	ld [wTopMenuItemX], a
	ld [wCustomStarterPositionX], a
	call SetCursorPositionsFromCustomStarter ; overkill, i know
	ld a, [wCustomStarterPositionX]
.done
	jp .eraseOldMenuCursor
	jp .loop


StarterSpeciesText:
	db "STARTER SPECIES@"
StarterSpeciesWhiteText:
	db "                @"
StarterSpeciesHoldtext:
	db "HOLD L/R : FASTER@"

StarterDVsText:
	db "STARTER DVS@"
StarterAtkText:
	db " ATK:   @"
StarterDefText:
	db " DEF:   @"
StarterSpeText:
	db " SPE:   @"
StarterSpcText:
	db " SPC:   @"

StarterBallText:
	db "STARTER BALL@"
StarterBallChoiceText:
	db " LEFT  MID  RIGHT@"

StarterCancelText:
	db "CANCEL@"


; reads the custom starter variables and places menu cursors in the correct positions within the starter menu
SetCursorPositionsFromCustomStarter:
	xor a
	hlcoord 1, 2
	call .placeUnfilledRightArrowStarter
	hlcoord 1, 6
	call .placeUnfilledRightArrowStarter
	hlcoord 1, 7
	call .placeUnfilledRightArrowStarter
	hlcoord 1, 8
	call .placeUnfilledRightArrowStarter
	hlcoord 1, 9
	call .placeUnfilledRightArrowStarter
	hlcoord 0, 13
	ld a, [wCustomStarterPositionX]
	call .placeUnfilledRightArrowStarter
	xor a
; cursor in front of Cancel
	hlcoord 1, 16
.placeUnfilledRightArrowStarter
	ld e, a
	ld d, 0
	add hl, de
	ld [hl], "▷"
	ret


SetCustomStarterInternalID:
	ld a, [wCustomStarterAlphabeticalID]
	ld d, 0
	ld e, a
	ld hl, PokemonAlphabeticalList
	add hl, de
	ld a, [hl] ; gets internal Pokémon ID
	ld [wCustomStarterInternalID], a
	ret

StarterNameDisplay:	
	hlcoord 1, 2
	ld de, StarterSpeciesWhiteText
	call PlaceString

	call SetCustomStarterInternalID
	ld a, [wCustomStarterInternalID]
	ld [wd11e], a
	call GetMonName ; outputs in wcd6d
	hlcoord 3, 2
	call PlaceString
	ret


StarterDVsDisplay:
	hlcoord 7, 6
	ld de, wCustomStarterAtkDV
	lb bc, LEADING_ZEROES | 1, 2
	call PrintNumber
	hlcoord 7, 7
	ld de, wCustomStarterDefDV
	lb bc, LEADING_ZEROES | 1, 2
	call PrintNumber
	hlcoord 7, 8
	ld de, wCustomStarterSpeDV
	lb bc, LEADING_ZEROES | 1, 2
	call PrintNumber
	hlcoord 7, 9
	ld de, wCustomStarterSpcDV
	lb bc, LEADING_ZEROES | 1, 2
	call PrintNumber
	ret


PokemonAlphabeticalList::
	db ABRA			;  0
	db AERODACTYL
	db ALAKAZAM
	db ARBOK
	db ARCANINE
	db ARTICUNO
	db BEEDRILL
	db BELLSPROUT
	db BLASTOISE
	db BULBASAUR
	db BUTTERFREE	; 10
	db CATERPIE
	db CHANSEY
	db CHARIZARD
	db CHARMANDER
	db CHARMELEON
	db CLEFABLE
	db CLEFAIRY
	db CLOYSTER
	db CUBONE
	db DEWGONG		; 20
	db DIGLETT
	db DITTO
	db DODRIO
	db DODUO
	db DRAGONAIR
	db DRAGONITE
	db DRATINI
	db DROWZEE
	db DUGTRIO
	db EEVEE		; 30
	db EKANS
	db ELECTABUZZ
	db ELECTRODE
	db EXEGGCUTE
	db EXEGGUTOR
	db FARFETCHD
	db FEAROW
	db FLAREON
	db GASTLY
	db GENGAR		; 40
	db GEODUDE
	db GLOOM
	db GOLBAT
	db GOLDEEN
	db GOLDUCK
	db GOLEM
	db GRAVELER
	db GRIMER
	db GROWLITHE
	db GYARADOS		; 50
	db HAUNTER
	db HITMONCHAN
	db HITMONLEE
	db HORSEA
	db HYPNO
	db IVYSAUR
	db JIGGLYPUFF
	db JOLTEON
	db JYNX
	db KABUTO		; 60
	db KABUTOPS
	db KADABRA
	db KAKUNA
	db KANGASKHAN
	db KINGLER
	db KOFFING
	db KRABBY
	db LAPRAS
	db LICKITUNG
	db MACHAMP		; 70
	db MACHOKE
	db MACHOP
	db MAGIKARP
	db MAGMAR
	db MAGNEMITE
	db MAGNETON
	db MANKEY
	db MAROWAK
	db MEOWTH
	db METAPOD		; 80
	db MEW
	db MEWTWO
	db MOLTRES
	db MR_MIME
	db MUK
	db NIDOKING
	db NIDOQUEEN
	db NIDORAN_F
	db NIDORAN_M
	db NIDORINA		; 90
	db NIDORINO
	db NINETALES
	db ODDISH
	db OMANYTE
	db OMASTAR
	db ONIX
	db PARAS
	db PARASECT
	db PERSIAN
	db PIDGEOT		;100
	db PIDGEOTTO
	db PIDGEY
	db PIKACHU
	db PINSIR
	db POLIWAG
	db POLIWHIRL
	db POLIWRATH
	db PONYTA
	db PORYGON
	db PRIMEAPE		;110
	db PSYDUCK
	db RAICHU
	db RAPIDASH
	db RATICATE
	db RATTATA
	db RHYDON
	db RHYHORN
	db SANDSHREW
	db SANDSLASH
	db SCYTHER		;120
	db SEADRA
	db SEAKING
	db SEEL
	db SHELLDER
	db SLOWBRO
	db SLOWPOKE
	db SNORLAX
	db SPEAROW
	db SQUIRTLE
	db STARMIE		;130
	db STARYU
	db TANGELA
	db TAUROS
	db TENTACOOL
	db TENTACRUEL
	db VAPOREON
	db VENOMOTH
	db VENONAT
	db VENUSAUR
	db VICTREEBEL	;140
	db VILEPLUME
	db VOLTORB
	db VULPIX
	db WARTORTLE
	db WEEDLE
	db WEEPINBELL
	db WEEZING
	db WIGGLYTUFF
	db ZAPDOS
	db ZUBAT		;150
	db -1