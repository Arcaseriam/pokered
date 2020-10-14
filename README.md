# Pokémon Red and Blue - Custom Starter ROM

This is a **non-PSR-official, modified** version of the disassembly of Pokémon Red and Blue.
Modifications are made to offer starter customization for the player, as well as workarounds for RNG manipulations.

It builds the following ROMs:

- Pokemon Red pokered.gbc `sha1: b841b9e5b42c91e855325c8e408e03e0391fbef9` `crc32: 4ED78FBC`
- Pokemon Blue pokeblue.gbc `sha1: 0178ea17e02dc433e0e14faf19b9c8e2d272ca53` `crc32: AA06507F`
- pokeblue_debug.gbc (debug build) `sha1: 1dbe9d76edd3a4e3d70f8f064d18c0069e2af714`

To set up the repository, see [**INSTALL.md**](INSTALL.md).

If you only need to apply the changes to an existing vanilla ROM, see [**PATCHES.md**](PATCHES.md)

## Main changes
- Custom starter & encounter menus available before New Game, through the Option menu.
- The encounter menu allows to choose up to 3 forced encounters with perfect DVs. Encounter are forced when no Repel is active.
- Player's PC : 6 Repels available.
- Catch mechanic : guaranteed with any Ball type.
- Route 3 : only Pidgey and Spearow encounters.
- Mt. Moon : no L11 Zubat encounters.
- Mt. Moon B2F : only L10 Paras encounters (last floor).
- Route 4 : only Sandshrew encounters in Blue version.
- Vermillion Gym : doors can be opened with any two cans.

## Visuals
![Image of Option menu](https://i.imgur.com/NnjrHiX.png)
![Image of Starter menu](https://i.imgur.com/JC7d4n1.png)
![Image of Encounter menu](https://i.imgur.com/oECURUi.png)

## See also

- **Gen 1-3 Pokémon Speedrunning:** [Discord][speedrun-discord]

Other disassembly projects:

- [**Pokémon Crystal - Custom Starter**][pokecrystal-custom-starter]
- [**Pokémon Red/Blue**][pokered]

[speedrun-discord]: https://discord.gg/NjQFEkc
[pokecrystal-custom-starter]: https://github.com/Arcaseriam/pokecrystal-custom-starter
[pokered]: https://github.com/pret/pokered
