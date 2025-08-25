
# BL HUD V1

A sleek and modern in-game HUD for FiveM, supporting ESX, QBCore, and standalone setups.

## Features

- Clean circular HUD with health, armor, hunger, and thirst indicators
- Displays cash, bank balance, and speedometer
- Auto refreshes on player spawn/login
- Admin command `/adminheal` to refill needs
- Optional support for `okokBanking`, `qs-banking`, and `ox_inventory`
- Fully integrated with `bl_lib` for shared utility functions
- MIT Licensed and ready for public use

## Requirements

- [bl_lib](https://github.com/yourusername/bl_lib) – Shared utility library used across BL scripts
- ESX or QBCore framework (or run standalone with limited features)

## Installation

1. Clone or download this repo:
   ```bash
   git clone https://github.com/yourusername/bl_hud_v1.git
   ```

2. Add to your `server.cfg`:
   ```
   ensure bl_lib
   ensure bl_hud_v1
   ```

3. Optional: Modify framework settings or icons in the config if needed.

## Configuration

- You can modify the visual HUD by editing `html/style.css`
- Icons are located in `html/icons/` and use `.svg` format
- To toggle the HUD in-game, press **F10**

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
