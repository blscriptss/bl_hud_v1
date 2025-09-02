
![BL HUD Preview](preview.png)

# BL HUD V1

A sleek and modern HUD for FiveM, supporting ESX, QBCore, and standalone frameworks.
Includes circular indicators for player stats, banking integration, and speed display.

---

✨ **Features**

- Framework Compatibility: ESX, QBCore, Standalone
- Inventory Compatibility: ox_inventory, qs-inventory, qb-inventory
- Status Circles: Health, Armor, Hunger, Thirst
- Banking Display: Cash & Bank (okokBanking, qs-banking, ox support)
- Auto Refresh: HUD loads on spawn/login automatically
- Admin Tools: `/adminheal` command to refill needs
- Customizable: Icons, layout, styles, and status polling
- `bl_lib` Integration: Uses shared BL library utilities

---

📦 **Installation**

### 1. Download the Resource

Clone or download the latest release:

```bash
git clone https://github.com/Bluey04/bl_hud_v1.git
```

### 2. Install Required Dependency

This script requires `bl_lib`.

- Download or clone `bl_lib`
- Place it in your `resources/[bl]` folder
- Add to `server.cfg` before starting this HUD:

```bash
ensure bl_lib
ensure bl_hud_v1
```

---

⚙️ **Configuration**

Edit `config/config.lua`:

```lua
Config.Framework = "qbcore" -- qbcore, esx, or standalone
Config.Inventory = "ox"     -- ox, qb, or qs
```

Additional configuration:

- Customize circle positions in `style.css`
- Add or replace icons in `html/icons/`

---

🛠️ **Usage**

- `/adminheal` — Refill hunger and thirst instantly

---

📄 **License**

Licensed under the MIT License — free to use, modify, and share with credit.

---

💳 **Donations**

Support development and future updates:

- PayPal — BL SCRIPTS

---

📢 **Support**

- Open a GitHub issue
- Join our Discord: [discord.gg/9fuJWEGSmK]
- Ask in the FiveM community forums

---

📜 **Changelog**

### v1.0.0 (2025-08-25)

- Initial release
- Circular HUD with dynamic status indicators
- Bank & cash display
- Admin heal command
- Multi-framework support
