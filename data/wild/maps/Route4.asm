Route4Mons:
	db 20 ; grass encounter rate
	db  6, SANDSHREW
	db  6, SANDSHREW
	db  6, SANDSHREW
IF DEF(_RED)
	db  6, EKANS
	db  8, SPEAROW
	db 10, EKANS
	db 12, RATTATA
	db 12, SPEAROW
	db  8, EKANS
	db 12, EKANS
ENDC
IF DEF(_BLUE) ; CHANGE
	db  6, SANDSHREW
	db  8, SANDSHREW ;db  8, SPEAROW
	db  8, SANDSHREW
	db  8, SANDSHREW ;db 12, RATTATA
	db  8, SANDSHREW ;db 12, SPEAROW
	db  8, SANDSHREW
	db  8, SANDSHREW
ENDC
	db 0 ; water encounter rate
