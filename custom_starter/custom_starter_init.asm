; used with CustomizableAreas
CUSTOMIZABLE_AREAS_SIZE EQU 52
CUSTOMIZABLE_AREAS_LENGTH EQU 17

; used with wAreaX
	const_def
	const AREA_ID          ; 0
	const AREA_LEVEL       ; 1
	const AREA_SPECIES     ; 2
	const AREA_POS         ; 3
	const AREA_SPECIES_POS ; 4
NUM_AREA_SLOTS EQU const_value

 ; CHANGE
InitCustomStarter:
	push af
	push hl

	ld a, 129 ; Default alphabetical-ordered starter ID ; Squirtle
	ld [wCustomStarterAlphabeticalID], a
	call SetCustomStarterIDs
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
	
	ld a, -1
	ld hl, wArea1ID
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	
	xor a
	ld [wArea1Pos], a
	ld [wArea2Pos], a
	ld [wArea3Pos], a
	ld [wAreaIsForcedEncounter], a
	
	pop hl
	pop af
	ret
	
SetCustomStarterIDs:
	ld a, [wCustomStarterAlphabeticalID]
	ld d, 0
	ld e, a
	ld hl, PokemonAlphabeticalList
	add hl, de
	add hl, de
	ld a, [hli] ; gets internal Pokémon ID
	ld [wCustomStarterInternalID], a
	ld a, [hl] ; gets Dex Pokémon ID
	ld [wCustomStarterDexID], a
	ret
	
PokemonAlphabeticalList::
	db ABRA,        DEX_ABRA		;  0
	db AERODACTYL,  DEX_AERODACTYL
	db ALAKAZAM,    DEX_ALAKAZAM
	db ARBOK,       DEX_ARBOK
	db ARCANINE,    DEX_ARCANINE
	db ARTICUNO,    DEX_ARTICUNO
	db BEEDRILL,    DEX_BEEDRILL
	db BELLSPROUT,  DEX_BELLSPROUT
	db BLASTOISE,   DEX_BLASTOISE
	db BULBASAUR,   DEX_BULBASAUR
	db BUTTERFREE,  DEX_BUTTERFREE	; 10
	db CATERPIE,    DEX_CATERPIE
	db CHANSEY,     DEX_CHANSEY
	db CHARIZARD,   DEX_CHARIZARD
	db CHARMANDER,  DEX_CHARMANDER
	db CHARMELEON,  DEX_CHARMELEON
	db CLEFABLE,    DEX_CLEFABLE
	db CLEFAIRY,    DEX_CLEFAIRY
	db CLOYSTER,    DEX_CLOYSTER
	db CUBONE,      DEX_CUBONE
	db DEWGONG,     DEX_DEWGONG		; 20
	db DIGLETT,     DEX_DIGLETT
	db DITTO,       DEX_DITTO
	db DODRIO,      DEX_DODRIO
	db DODUO,       DEX_DODUO
	db DRAGONAIR,   DEX_DRAGONAIR
	db DRAGONITE,   DEX_DRAGONITE
	db DRATINI,     DEX_DRATINI
	db DROWZEE,     DEX_DROWZEE
	db DUGTRIO,     DEX_DUGTRIO
	db EEVEE,       DEX_EEVEE		; 30
	db EKANS,       DEX_EKANS
	db ELECTABUZZ,  DEX_ELECTABUZZ
	db ELECTRODE,   DEX_ELECTRODE
	db EXEGGCUTE,   DEX_EXEGGCUTE
	db EXEGGUTOR,   DEX_EXEGGUTOR
	db FARFETCHD,   DEX_FARFETCHD
	db FEAROW,      DEX_FEAROW
	db FLAREON,     DEX_FLAREON
	db GASTLY,      DEX_GASTLY
	db GENGAR,      DEX_GENGAR		; 40
	db GEODUDE,     DEX_GEODUDE
	db GLOOM,       DEX_GLOOM
	db GOLBAT,      DEX_GOLBAT
	db GOLDEEN,     DEX_GOLDEEN
	db GOLDUCK,     DEX_GOLDUCK
	db GOLEM,       DEX_GOLEM
	db GRAVELER,    DEX_GRAVELER
	db GRIMER,      DEX_GRIMER
	db GROWLITHE,   DEX_GROWLITHE
	db GYARADOS,    DEX_GYARADOS	; 50
	db HAUNTER,     DEX_HAUNTER
	db HITMONCHAN,  DEX_HITMONCHAN
	db HITMONLEE,   DEX_HITMONLEE
	db HORSEA,      DEX_HORSEA
	db HYPNO,       DEX_HYPNO
	db IVYSAUR,     DEX_IVYSAUR
	db JIGGLYPUFF,  DEX_JIGGLYPUFF
	db JOLTEON,     DEX_JOLTEON
	db JYNX,        DEX_JYNX
	db KABUTO,      DEX_KABUTO		; 60
	db KABUTOPS,    DEX_KABUTOPS
	db KADABRA,     DEX_KADABRA
	db KAKUNA,      DEX_KAKUNA
	db KANGASKHAN,  DEX_KANGASKHAN
	db KINGLER,     DEX_KINGLER
	db KOFFING,     DEX_KOFFING
	db KRABBY,      DEX_KRABBY
	db LAPRAS,      DEX_LAPRAS
	db LICKITUNG,   DEX_LICKITUNG
	db MACHAMP,     DEX_MACHAMP		; 70
	db MACHOKE,     DEX_MACHOKE
	db MACHOP,      DEX_MACHOP
	db MAGIKARP,    DEX_MAGIKARP
	db MAGMAR,      DEX_MAGMAR
	db MAGNEMITE,   DEX_MAGNEMITE
	db MAGNETON,    DEX_MAGNETON
	db MANKEY,      DEX_MANKEY
	db MAROWAK,     DEX_MAROWAK
	db MEOWTH,      DEX_MEOWTH
	db METAPOD,     DEX_METAPOD		; 80
	db MEW,         DEX_MEW
	db MEWTWO,      DEX_MEWTWO
	db MOLTRES,     DEX_MOLTRES
	db MR_MIME,     DEX_MR_MIME
	db MUK,         DEX_MUK
	db NIDOKING,    DEX_NIDOKING
	db NIDOQUEEN,   DEX_NIDOQUEEN
	db NIDORAN_F,   DEX_NIDORAN_F
	db NIDORAN_M,   DEX_NIDORAN_M
	db NIDORINA,    DEX_NIDORINA	; 90
	db NIDORINO,    DEX_NIDORINO
	db NINETALES,   DEX_NINETALES
	db ODDISH,      DEX_ODDISH
	db OMANYTE,     DEX_OMANYTE
	db OMASTAR,     DEX_OMASTAR
	db ONIX,        DEX_ONIX
	db PARAS,       DEX_PARAS
	db PARASECT,    DEX_PARASECT
	db PERSIAN,     DEX_PERSIAN
	db PIDGEOT,     DEX_PIDGEOT		;100
	db PIDGEOTTO,   DEX_PIDGEOTTO
	db PIDGEY,      DEX_PIDGEY
	db PIKACHU,     DEX_PIKACHU
	db PINSIR,      DEX_PINSIR
	db POLIWAG,     DEX_POLIWAG
	db POLIWHIRL,   DEX_POLIWHIRL
	db POLIWRATH,   DEX_POLIWRATH
	db PONYTA,      DEX_PONYTA
	db PORYGON,     DEX_PORYGON
	db PRIMEAPE,    DEX_PRIMEAPE	;110
	db PSYDUCK,     DEX_PSYDUCK
	db RAICHU,      DEX_RAICHU
	db RAPIDASH,    DEX_RAPIDASH
	db RATICATE,    DEX_RATICATE
	db RATTATA,     DEX_RATTATA
	db RHYDON,      DEX_RHYDON
	db RHYHORN,     DEX_RHYHORN
	db SANDSHREW,   DEX_SANDSHREW
	db SANDSLASH,   DEX_SANDSLASH
	db SCYTHER,     DEX_SCYTHER		;120
	db SEADRA,      DEX_SEADRA
	db SEAKING,     DEX_SEAKING
	db SEEL,        DEX_SEEL
	db SHELLDER,    DEX_SHELLDER
	db SLOWBRO,     DEX_SLOWBRO
	db SLOWPOKE,    DEX_SLOWPOKE
	db SNORLAX,     DEX_SNORLAX
	db SPEAROW,     DEX_SPEAROW
	db SQUIRTLE,    DEX_SQUIRTLE
	db STARMIE,     DEX_STARMIE		;130
	db STARYU,      DEX_STARYU
	db TANGELA,     DEX_TANGELA
	db TAUROS,      DEX_TAUROS
	db TENTACOOL,   DEX_TENTACOOL
	db TENTACRUEL,  DEX_TENTACRUEL
	db VAPOREON,    DEX_VAPOREON
	db VENOMOTH,    DEX_VENOMOTH
	db VENONAT,     DEX_VENONAT
	db VENUSAUR,    DEX_VENUSAUR
	db VICTREEBEL,  DEX_VICTREEBEL	;140
	db VILEPLUME,   DEX_VILEPLUME
	db VOLTORB,     DEX_VOLTORB
	db VULPIX,      DEX_VULPIX
	db WARTORTLE,   DEX_WARTORTLE
	db WEEDLE,      DEX_WEEDLE
	db WEEPINBELL,  DEX_WEEPINBELL
	db WEEZING,     DEX_WEEZING
	db WIGGLYTUFF,  DEX_WIGGLYTUFF
	db ZAPDOS,      DEX_ZAPDOS
	db ZUBAT,       DEX_ZUBAT		;150
	db -1

GetEncounterTable:
; in : a = table offset
; out: hl = adress to encounter table
;           0x0000 if doesn't exist
;      de = adress to area name
;       b = map ID
	push af
	cp CUSTOMIZABLE_AREAS_SIZE
	jr c, .good
	ld a, 0

.good
	ld hl, CustomizableAreas
	ld c, CUSTOMIZABLE_AREAS_LENGTH
	ld b, 0
	call AddNTimes
	ld a, [hli] ; map ID
	ld b, a
	push bc
	;push af
	ld d, h ; map name
	ld e, l
	push de
	
	cp -1
	jr nz, .good2
	lb hl, 0, 0
	;pop af
	jr .done
.good2
	;pop af
	ld [wCurMap], a
	farcall LoadWildData
	ld a, [wGrassRate]
	and a 
	jr nz, .grass
	ld hl, wWaterMons
	jr .done
.grass
	ld hl, wGrassMons
	;fallthrough
.done
	pop de
	pop bc
	pop af
	ret
	

CustomizableAreas:
; search in WildDataPointers
	db -1,                  "NONE           @"
	db POKEMON_MANSION_B1F, "CINNABAR MA.B1F@"
	db POKEMON_MANSION_1F,  "CINNABAR MA.1F @"
	db POKEMON_MANSION_2F,  "CINNABAR MA.2F @"
	db POKEMON_MANSION_3F,  "CINNABAR MA.3F @"
	db DIGLETTS_CAVE,       "DIGLETT'S CAVE @"
	db POKEMON_TOWER_1F,    "LAVENDER TOW.1F@"
	db POKEMON_TOWER_2F,    "LAVENDER TOW.2F@"
	db POKEMON_TOWER_3F,    "LAVENDER TOW.3F@"
	db POKEMON_TOWER_4F,    "LAVENDER TOW.4F@"
	db POKEMON_TOWER_5F,    "LAVENDER TOW.5F@"
	db POKEMON_TOWER_6F,    "LAVENDER TOW.6F@"
	db POKEMON_TOWER_7F,    "LAVENDER TOW.7F@"
	db POWER_PLANT,         "POWER PLANT    @"
	db ROCK_TUNNEL_B1F,     "ROCK TUNNEL B1F@"
	db ROCK_TUNNEL_1F,      "ROCK TUNNEL 1F @"
	db ROUTE_1,             "ROUTE 1        @"
	db ROUTE_2,             "ROUTE 2        @"
	db ROUTE_5,             "ROUTE 5        @"
	db ROUTE_6,             "ROUTE 6        @"
	db ROUTE_7,             "ROUTE 7        @"
	db ROUTE_8,             "ROUTE 8        @"
	db ROUTE_9,             "ROUTE 9        @"
	db ROUTE_10,            "ROUTE 10       @"
	db ROUTE_11,            "ROUTE 11       @"
	db ROUTE_12,            "ROUTE 12       @"
	db ROUTE_13,            "ROUTE 13       @"
	db ROUTE_14,            "ROUTE 14       @"
	db ROUTE_15,            "ROUTE 15       @"
	db ROUTE_16,            "ROUTE 16       @"
	db ROUTE_17,            "ROUTE 17       @"
	db ROUTE_18,            "ROUTE 18       @"
	db ROUTE_19,            "ROUTE 19       @"
	db ROUTE_20,            "ROUTE 20       @"
	db ROUTE_21,            "ROUTE 21       @"
	db ROUTE_22,            "ROUTE 22       @"
	db ROUTE_23,            "ROUTE 23       @"
	db ROUTE_24,            "ROUTE 24       @"
	db ROUTE_25,            "ROUTE 25       @"
	db SAFARI_ZONE_CENTER,  "SAFARI CENTER  @"
	db SAFARI_ZONE_EAST,    "SAFARI EAST    @"
	db SAFARI_ZONE_NORTH,   "SAFARI NORTH   @"
	db SAFARI_ZONE_WEST,    "SAFARI WEST    @"
	db SEAFOAM_ISLANDS_1F,  "SEAFOAM ISL.1F @"
	db SEAFOAM_ISLANDS_B1F, "SEAFOAM ISL.B1F@"
	db SEAFOAM_ISLANDS_B2F, "SEAFOAM ISL.B2F@"
	db SEAFOAM_ISLANDS_B3F, "SEAFOAM ISL.B3F@"
	db SEAFOAM_ISLANDS_B4F, "SEAFOAM ISL.B4F@"
	db VICTORY_ROAD_1F,     "VICTORY ROAD 1F@"
	db VICTORY_ROAD_2F,     "VICTORY ROAD 2F@"
	db VICTORY_ROAD_3F,     "VICTORY ROAD 3F@"
	db VIRIDIAN_FOREST,     "VIRIDIAN FOREST@"