# Pokémon Red and Blue - Custom Starter ROM

This is a **non-PSR-official, modified** version of the disassembly of Pokémon Red and Blue.
Modifications are made to offer starter customization for the player, as well as workarounds for RNG manipulations.

It builds the following ROMs:

- Pokemon Red pokered.gbc `sha1: 63b9f8d503d9d6bf93e85b785f276ee6331c9400` `crc32: F3AC9F70`
- Pokemon Blue pokeblue.gbc `sha1: 53aa2625a9190a350a080f5d1904050a1eed97b7` `crc32: DFFC9773`
- pokeblue_debug.gbc (debug build) `sha1: d654848cda675de3eda16e95e8029d458ff6522b`

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
