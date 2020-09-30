; this function temporarily makes the starters (and Ivysaur) seen
; so that the full Pokedex information gets displayed in Oak's lab
StarterDex:
	ld a, 1 << (DEX_BULBASAUR - 1) | 1 << (DEX_IVYSAUR - 1) | 1 << (DEX_CHARMANDER - 1) | 1 << (DEX_SQUIRTLE - 1)
	ld [wPokedexOwned], a
	
	ld a, [wCustomStarterDexID] ; CHANGE
	dec a
	ld c, a
	ld b, FLAG_SET
	ld hl, wPokedexOwned
	predef FlagActionPredef ; sets custom starter dex flag to see its description in Oak's Lab
	
	predef ShowPokedexData
	xor a
	ld [wPokedexOwned], a
	ret
