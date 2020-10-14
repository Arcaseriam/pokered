; CHANGE
DisplayStarterEncounterMenu:
	hlcoord 0, 0
	ld b, 14
	ld c, 18
	call TextBoxBorder
	
	hlcoord 1, 1
	ld de, Area1Text
	call PlaceString
	hlcoord 1, 3
	ld de, AreaSpeciesText
	call PlaceString
	hlcoord 2, 4
	ld de, SingleLText
	call PlaceString
	
	hlcoord 1, 6
	ld de, Area2Text
	call PlaceString
	hlcoord 1, 8
	ld de, AreaSpeciesText
	call PlaceString
	hlcoord 2, 9
	ld de, SingleLText
	call PlaceString
	
	hlcoord 1, 11
	ld de, Area3Text
	call PlaceString
	hlcoord 1, 13
	ld de, AreaSpeciesText
	call PlaceString
	hlcoord 2, 14
	ld de, SingleLText
	call PlaceString
	
	hlcoord 2, 16
	ld de, StarterEncounterCancelText
	call PlaceString
	
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	inc a
	ld [wLetterPrintingDelayFlags], a	
	call SetEmptyCursors
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
	call Delay3 ;
.loop
	call PlaceMenuCursor
	call SetAndDisplayEncounters
.getJoypadStateLoop
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	ld b, a
	and A_BUTTON | B_BUTTON | START | D_RIGHT | D_LEFT | D_UP | D_DOWN ; any key besides select pressed?
	jr z, .getJoypadStateLoop
	bit BIT_B_BUTTON, b ; B button pressed?
	jr nz, .exitMenu
	bit BIT_START, b ; Start button pressed?
	jr nz, .exitMenu
	bit BIT_A_BUTTON, b ; A button pressed?
	jr z, .checkDirectionKeys
	ld a, [wTopMenuItemY]
	cp 16 ; is the cursor on Cancel?
	jr nz, .loop
.exitMenu
	xor a
	ld [hJoy6], a
	ld [hJoy7], a
	ret
.checkDirectionKeys
	ld a, [wTopMenuItemY]
	bit BIT_D_DOWN, b ; Down pressed?
	jr nz, .downPressed
	bit BIT_D_UP, b ; Up pressed?
	jr nz, .upPressed
	cp 2 ; cursor in Area 1?
	jr z, .cursorInArea1
	cp 4 ; cursor in Area 1 Species?
	jp z, .cursorInArea1Species
	cp 7 ; cursor in Area 2?
	jr z, .cursorInArea2
	cp 9 ; cursor in Area 2 Species?
	jp z, .cursorInArea2Species
	cp 12 ; cursor in Area 3?
	jr z, .cursorInArea3
	cp 14 ; cursor in Area 3 species?
	jp z, .cursorInArea3Species
	jr .loop
.cursorInArea1
	ld hl, wArea1ID
	jr .cursorInArea
.cursorInArea2
	ld hl, wArea2ID
	jr .cursorInArea
.cursorInArea3	
	ld hl, wArea3ID
	;fallthrough
.cursorInArea
	push hl
	bit BIT_D_LEFT, b ; Left pressed?
	jp nz, .pressedLeftInArea
	jp .pressedRightInArea
.downPressed
	ld a, 1
	ld [wTopMenuItemX], a
	ld a, [wTopMenuItemY]
	ld hl, wTopMenuItemX
	cp 16 ; on Cancel ?
	ld b, -14
	jr z, .updateMenuVariables
	cp 2 ; on Area 1 ?
	ld b, 2
	jr z, .updateMenuVariables
	cp 4 ; on Area 1 Species ?
	ld b, 3
	jr z, .updateMenuVariables
	cp 7 ; on Area 2 ?
	ld b, 2
	jr z, .updateMenuVariables
	cp 9 ; on Area 2 Species ?
	ld b, 3
	jr z, .updateMenuVariables
	cp 12 ; on Area 3 ?
	ld b, 2
	jr z, .updateMenuVariables
	cp 14 ; on Area 3 Species?
	ld b, 2
	jr z, .updateMenuVariables
	jp .loop
.upPressed
	ld a, 1
	ld [wTopMenuItemX], a
	ld a, [wTopMenuItemY]
	ld hl, wTopMenuItemX
	jr z, .updateMenuVariables
	cp 2 ; on Area 1 ?
	ld b, 14
	jr z, .updateMenuVariables
	cp 4 ; on Area 1 Species ?
	ld b, -2
	jr z, .updateMenuVariables
	cp 7 ; on Area 2 ?
	ld b, -3
	jr z, .updateMenuVariables
	cp 9 ; on Area 2 Species ?
	ld b, -2
	jr z, .updateMenuVariables
	cp 12 ; on Area 3 ?
	ld b, -3
	jr z, .updateMenuVariables
	cp 14 ; on Area 3 Species?
	ld b, -2
	jr z, .updateMenuVariables
	cp 16 ; on Cancel ?
	ld b, -2
	jp .loop
.updateMenuVariables
	add b
	ld [wTopMenuItemY], a
	ld a, [hl]
	ld [wTopMenuItemX], a
	call PlaceUnfilledArrowMenuCursor
	jp .loop

.pressedLeftInArea
	ld c, AREA_POS
	ld b, 0
	add hl, bc
	ld a, [hl] ; Area ID pos
	dec a
	;cp -1
	;jr z, .updateArea
	cp CUSTOMIZABLE_AREAS_SIZE
	jr c, .updateArea
	ld a, CUSTOMIZABLE_AREAS_SIZE - 1 ; handles underflow case
	jr .updateArea
.pressedRightInArea
	ld c, AREA_POS
	ld b, 0
	add hl, bc
	ld a, [hl] ; Area ID pos
	inc a
	cp CUSTOMIZABLE_AREAS_SIZE
	jr c, .updateArea
	ld a, 0 ; handles overflow case
	; fallthrough
.updateArea
	pop hl
	push af
	ld a, -1
	ld [hli], a  ; ID
	ld [hli], a ; Level
	ld [hli], a ; Species
	pop af
	ld [hli], a  ; Pos
	ld a, -1
	ld [hl], a   ; Species pos
	jp .loop

.cursorInArea1Species
	ld hl, wArea1SpeciesPos
	jr .cursorInAreaSpecies
.cursorInArea2Species
	ld hl, wArea2SpeciesPos
	jr .cursorInAreaSpecies
.cursorInArea3Species
	ld hl, wArea3SpeciesPos
	;fallthrough
.cursorInAreaSpecies
	ld a, [wTopMenuItemX]
	bit BIT_D_LEFT, b ; Left pressed?
	jp nz, .pressedLeftInAreaSpecies
	jp .pressedRightInAreaSpecies
.pressedLeftInAreaSpecies
	ld a, [hl]
	dec a
	cp -2
	jr z, .lastSlot
	jr .done
.lastSlot
	ld a, 9
	jr .done
.pressedRightInAreaSpecies
	ld a, [hl]
	inc a
	cp 10
	jr z, .firstSlot
	jr .done
.firstSlot
	ld a, -1
	;fallthrough
.done
	ld [hl], a
	jp .loop

Area1Text:
	db "AREA 1@"
Area2Text:
	db "AREA 2@"
Area3Text:
	db "AREA 3@"

AreaSpeciesText:
	db "FORCED SPECIES@"

StarterEncounterCancelText:
	db "CANCEL@"


SetEmptyCursors:
	xor a
	hlcoord 1, 2
	call .placeUnfilledRightArrowStarter
	hlcoord 1, 4
	
	call .placeUnfilledRightArrowStarter
	hlcoord 1, 7
	call .placeUnfilledRightArrowStarter
	hlcoord 1, 9
	
	call .placeUnfilledRightArrowStarter
	hlcoord 1, 12
	call .placeUnfilledRightArrowStarter
	hlcoord 1, 14
	call .placeUnfilledRightArrowStarter
; cursor in front of Cancel
	hlcoord 1, 16
.placeUnfilledRightArrowStarter
	ld e, a
	ld d, 0
	add hl, de
	ld [hl], "▷"
	ret


SetAndDisplayEncounters: ; please don't judge me, attempt at "better" code commented below
.area1
	ld a, [wArea1Pos]
	call GetEncounterTable
	ld a, b
	ld [wArea1ID], a
	push hl
	hlcoord 2, 2
	call PlaceString
	
	hlcoord 3, 4
	ld de, WhiteText
	call PlaceString
	
	pop hl
	xor a
	or h
	jr nz, .go1
	or l
	jr nz, .go1
	jr .skip1
.go1
	ld a, [wArea1SpeciesPos]
	cp -1
	jr z, .skip1
	; we have a correct slot now
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli] ; level
	ld [wArea1Level], a
	ld a, [hl] ; species
	ld [wArea1Species], a
	
	hlcoord 3, 4
	ld de, wArea1Level
	lb bc, 1, 2
	call PrintNumber

	ld a, [wArea1Species]
	ld [wd11e], a
	call GetMonName
	hlcoord 6, 4
	call PlaceString
	jr .area2
.skip1
	hlcoord 6, 4
	ld de, NoneText
	call PlaceString
	;fallthrough
	
.area2
	ld a, [wArea2Pos]
	call GetEncounterTable
	ld a, b
	ld [wArea2ID], a
	push hl
	hlcoord 2, 7
	call PlaceString
	
	hlcoord 3, 9
	ld de, WhiteText
	call PlaceString
	
	pop hl
	xor a
	or h
	jr nz, .go2
	or l
	jr nz, .go2
	jr .skip2
.go2
	ld a, [wArea2SpeciesPos]
	cp -1
	jr z, .skip2
	; we have a correct slot now
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli] ; level
	ld [wArea2Level], a
	ld a, [hl] ; species
	ld [wArea2Species], a
	
	hlcoord 3, 9
	ld de, wArea2Level
	lb bc, 1, 2
	call PrintNumber

	ld a, [wArea2Species]
	ld [wd11e], a
	call GetMonName
	hlcoord 6, 9
	call PlaceString
	jr .area3
.skip2
	hlcoord 6, 9
	ld de, NoneText
	call PlaceString
	;fallthrough
	
.area3
	ld a, [wArea3Pos]
	call GetEncounterTable
	ld a, b
	ld [wArea3ID], a
	push hl
	hlcoord 2, 12
	call PlaceString
	
	hlcoord 3, 14
	ld de, WhiteText
	call PlaceString
	
	pop hl
	xor a
	or h
	jr nz, .go3
	or l
	jr nz, .go3
	jr .skip3
.go3
	ld a, [wArea3SpeciesPos]
	cp -1
	jr z, .skip3
	; we have a correct slot now
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli] ; level
	ld [wArea3Level], a
	ld a, [hl] ; species
	ld [wArea3Species], a
	
	hlcoord 3, 14
	ld de, wArea3Level
	lb bc, 1, 2
	call PrintNumber

	ld a, [wArea3Species]
	ld [wd11e], a
	call GetMonName
	hlcoord 6, 14
	call PlaceString
	jr .done
.skip3
	hlcoord 6, 14
	ld de, NoneText
	call PlaceString
	;fallthrough
	
.done
	ret


WhiteText:
	db "              @"	
SingleLText:
	db "L@"
NoneText:
	db "NONE@"



; failed attempt below, if someone can make this work
; until then, working "copy-pasted" code in production


; BaseTextPositions: ;failed
	; db 2, 2
	; db 3, 4
	; db 6, 4
	
; SetAndDisplayEncounters: ;failed
	; xor a
	; ld [wAreaCounter], a
	; ld hl, wArea1ID

; .loop
	; ld a, [wAreaCounter]
	; cp 3
	; jp nc, .done
	; ld b, a ; preparing Y offset
	; sla a
	; sla a
	; add b ; 5*counter
	; ld [wAreaYOffset], a
	; inc b
	; ld a, b
	; ld [wAreaCounter], a
	
	; ld a, h
	; ld [wCurrentAreaAddr], a
	; ld a, l
	; ld [wCurrentAreaAddr+1], a
	; ld c, AREA_POS
	; ld b, 0
	; add hl, bc ; wAreaXPos
	; ld a, [hl]
	; call GetEncounterTable
	; ld a, h
	; ld [wEncounterTableAddr], a
	; ld a, l
	; ld [wEncounterTableAddr+1], a
	; ld a, d
	; ld [wAreaTextAddr], a
	; ld a, e
	; ld [wAreaTextAddr+1], a
	; ;push bc ; b map ID
	; ld a, [wCurrentAreaAddr]
	; ld h, a
	; ld a, [wCurrentAreaAddr+1]
	; ld l, a
	; ;pop bc ; b map ID
	; ld a, b
	; ld [hl], a ; map ID
	
	; ; place area name
	; ld a, 0 ; pos 0
	; call GetBaseTextPosition
	; ld e, 0 ; X offset
	; ld a, [wAreaYOffset]
	; ld c, a
	; call CustomHlcoord
	; ld a, [wAreaTextAddr]
	; ld d, a
	; ld a, [wAreaTextAddr+1]
	; ld e, a
	; call PlaceString
	
	; ; "erase" old level-species text
	; ld a, 1 ; pos 1
	; call GetBaseTextPosition	
	; ld e, 0 ; X offset
	; ld a, [wAreaYOffset]
	; ld c, a
	; call CustomHlcoord
	; ld de, WhiteText
	; call PlaceString
	
	; ; check valid encounter table addr
	; ld a, [wEncounterTableAddr]
	; or a
	; jr nz, .go
	; ld h, a
	; ld a, [wEncounterTableAddr+1]
	; or a
	; jr nz, .go
	; jr .skip

; .go ; todo
	; ld l, a ; finishing building hl
	; push hl ; encounter table addr
	; ld a, [wCurrentAreaAddr]
	; ld h, a
	; ld a, [wCurrentAreaAddr+1]
	; ld l, a
	; ld c, AREA_SPECIES_POS
	; ld a, 0
	; ld b, a
	; add hl, bc ; wAreaXSpeciesPos
	; ld a, [hl]
	; pop hl ; encounter table addr
	; ld c, a ; [wAreaXSpeciesPos]
	; cp -1
	; jr z, .skip
	; ; we have a correct slot now
	; ld b, 0
	; add hl, bc
	; add hl, bc ; hl = encounter slot level addr
	; ld a, [hli] ; level
	; push hl ; species addr
	
	; ;save level
	; ld a, [wCurrentAreaAddr]
	; ld h, a
	; ld a, [wCurrentAreaAddr+1]
	; ld l, a
	; ld c, AREA_LEVEL
	; ld b, 0
	; add hl, bc ; wAreaXLevel
	; ld [hl], a
	; push hl ; wAreaXLevel
	
	; ; display level
	; ld a, 1 ; pos 1
	; call GetBaseTextPosition
	; ld e, 0 ; X offset
	; ld a, [wAreaYOffset]
	; ld c, a
	; call CustomHlcoord
	; pop de ; wAreaXLevel
	; lb bc, 1, 2
	; call PrintNumber

	; ; save species
	; pop hl ; species addr
	; ld a, [hl] ; species
	; ;push hl ; species addr
	; push af ; a species
	; ld a, [wCurrentAreaAddr]
	; ld h, a
	; ld a, [wCurrentAreaAddr+1]
	; ld l, a
	; ld a, AREA_SPECIES
	; ld c, a
	; ld b, 0
	; add hl, bc ; wAreaXSpecies
	; pop af ; a species
	; ld [hl], a
	; ld [wd11e], a ; setup for GetMonName
	; call GetMonName
	; push de ; mon name
	
	; ; display species
	; ld a, 2 ; pos 2
	; call GetBaseTextPosition
	; ld e, 0 ; X offset
	; ld a, [wAreaYOffset]
	; ld c, a
	; call CustomHlcoord
	; pop de ; mon name 
	; call PlaceString
	; ;fallthrough
	
; .skip
	; ; shift to next area
	; ld a, [wCurrentAreaAddr]
	; ld h, a
	; ld a, [wCurrentAreaAddr+1]
	; ld l, a
	; ld a, NUM_AREA_SLOTS
	; ld e, a
	; ld d, 0
	; add hl, de
	
	; jp .loop
	
; .done
	; ret

; GetBaseTextPosition: ;failed
; ; a = input text nb (0,1,2)
; ; b = output base Y
; ; d = output base X
	; push hl
	; push af

	; ld hl, BaseTextPositions

	; add l
	; add l
	; ld a, [hli]
	; ld d, a
	; ld a, [hl]
	; ld b, a
	
	; pop af
	; pop hl
	; ret
	
; CustomHlcoord: ;failed
; ; b = base Y, c = offset Y
; ; d = base X, e = offset X
; ; hl = output
	; push bc
	; push de 
	
	; ld a, b
	; add c ; Y + offset Y
	; ld c, a
	; ld b, 0
	; ld a, SCREEN_WIDTH
	; ld hl, wTileMap
	; push de ; AddNTimes might change these registers
	; call AddNTimes ; wTileMap+(Y+offsetY)*SCREEN_WIDTH
	
	; pop de
	; ld a, d
	; add e
	; ld e, a ; X + offset X
	; ld d, 0
	; add hl, de ; wTileMap+(Y+offsetY)*SCREEN_WIDTH+(X+offsetX)
	           ; ; equivalent to hlcoord X+offsetX, Y+offsetY
	; pop de
	; pop bc
	; ret
