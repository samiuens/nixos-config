# ⚙️ samiarda's nix configuration
[![nixos 24.11](https://img.shields.io/badge/NixOS-24.11-blue.svg?&logo=NixOS&logoColor=white)](https://nixos.org)

## 💫 Highlights
This repo contains the Nix configurations for my homelab servers, desktop and MacBook.

- ❄️ Nix flakes handles dependencies and packages
- 🏠 [home-manager](https://github.com/nix-community/home-manager) manages dotfiles and applications
- 🍎 [nix-darwin](https://github.com/LnL7/nix-darwin) for Mac configuration
- 🤫 [sops-nix](https://github.com/Mic92/sops-nix) for Secret management
- ⚡️ `justfile` contains useful aliases for many frequent and complicated commands
- ♻️ Automatic trash collection managed through `nix-gc`

## 👀 Overview
|   hostname   |         system          |         cpu         | ram  |         gpu         | role |  os  | status |
| :----------: | :---------------------: | :-----------------: | :--: | :-----------------: | :--: | :--: | :----: |
|  `smi-nixos` | [Prime B550M-A (Wi-Fi)] | [AMD Ryzen 7 2700X] | 32GB | XFX Radeon RX 6600  |  🖥️  |  ❄️   |  ✅  |
|  `smi-mac`   | [Macbook Pro M1 13"]    | Apple M1 8-core CPU | 8GB  | Apple M1 8-core GPU |  💻️  |  🍏   |  ✅  |
| `srv-prod-1` | ThinkCentre M625q       | AMD E2-9000e        | 2GB  | APU                 |  ☁️  |  ❄️   |  ✅  |

## 🆕 Getting started

### macOS
### NixOS

## 🛠️ Useful commands
Use `just` to access the aliases below:

## 🧩 Post installation

[Prime B550M-A (Wi-Fi)]: https://www.asus.com/us/motherboards-components/motherboards/prime/prime-b550m-a-wi-fi/
[AMD Ryzen 7 2700X]: https://www.amd.com/en/support/downloads/drivers.html/processors/ryzen/ryzen-2000-series/amd-ryzen-7-2700x.html
[XFX Radeon RX 6600]: https://www.xfxforce.com/shop/xfx-speedster-swft-210-amd-radeon-tm-rx-6600-core
[Macbook Pro M1 13"]: https://support.apple.com/en-us/111893