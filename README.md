# ⚙️ samiarda's nix configuration
[![nixos 24.11](https://img.shields.io/badge/NixOS-24.11-blue.svg?&logo=NixOS&logoColor=white)](https://nixos.org)
[![commit activity](https://img.shields.io/github/commit-activity/w/samiuens/nixos-config)](https://github.com/samiuens/nixos-config/commits/stage/)
[![mit license](https://img.shields.io/github/license/samiuens/nixos-config)](LICENSE)

## 💫 Highlights
This repo contains the Nix configurations for my desktop, macbook pro (m1) and my homelab servers.

- ❄️ Nix flakes handles dependencies and packages
- 🏠 [home-manager](https://github.com/nix-community/home-manager) manages dotfiles
- 🍎 [nix-darwin](https://github.com/LnL7/nix-darwin) for mac configuration
- 🤫 [sops-nix](https://github.com/Mic92/sops-nix) for encrypted secret management
- ⚡️ `justfile` contains useful aliases for many frequent and complicated commands
- ♻️ Automatic trash collection managed through `nix-gc`
- 🔑 Secure boot configuration *(coming soon...)*
- 🔒 Automatic Certifcate registration and renewal by `traefik`
- 🧩 Tailscale, Jellyfin, Netdata, among other self-hosted applications
- 🖼️ Configuration of the desired desktop environment on nixOS

## 👀 Overview
|   hostname   |         system          |         cpu         | ram  |         gpu         | role |  os  | status |
| :----------: | :---------------------: | :-----------------: | :--: | :-----------------: | :--: | :--: | :----: |
|  `smi-nixos` | [Prime B550M-A (Wi-Fi)] | [AMD Ryzen 7 2700X] | 32GB | XFX Radeon RX 6600  |  🖥️  |  ❄️   |  ✅  |
|  `smi-mac`   | [Macbook Pro M1 13"]    | Apple M1 8-core CPU | 8GB  | Apple M1 8-core GPU |  💻️  |  🍏   |  ✅  |
| `srv-prod-1` | ThinkCentre M625q       | AMD E2-9000e        | 2GB  | APU                 |  ☁️  |  ❄️   |  ✅  |

## 🆕 Getting started

> [!NOTE]
> The script needs to be run as sudo or the user needs sudo permissions.
```console
git clone git@github.com:samiuens/nixos-config.git && cd nixos-config
chmod +x install.sh && ./install.sh
```

### macOS
- On macOS, the script will install `nix` using the [Determinate Nix Installer].
- After running the script, you have to manually run the `nix-darwin` installer with the hostname, corresponding to the config, you want to apply.
- Also some settings are not covered by the nix configuration as they aren't available (see [Post Installation](#🧩-post-installation))

### NixOS
- On NixOS, no extra steps are needed, as the `nix` package manager is already installed.
- Run the config switch with the following command followed with the hostname corresponding tot he config, you want to apply.
- `sudo nixos-rebuild boot --flake ".#"`
- Restart the machine and you're ready to go!

### Servers
- Boot the [nixos minial iso image](https://nixos.org/download/) on the machine
- Generate the ssh keys on the both yubikeys for authentication by running `just sshkey <hostname> <sn> <keylabel> <copy: (y/n)>`
- The keys are getting automatically generated and put into the right directory and optionally copied to the local machine.
- Run the provision process with the following command: `./provision.sh`. The script guides you through the installation process.
- Lastly, add the host to your ssh config with the right hostname, username and key file path.

## 🧩 Post installation

[Prime B550M-A (Wi-Fi)]: https://www.asus.com/us/motherboards-components/motherboards/prime/prime-b550m-a-wi-fi/
[AMD Ryzen 7 2700X]: https://www.amd.com/en/support/downloads/drivers.html/processors/ryzen/ryzen-2000-series/amd-ryzen-7-2700x.html
[XFX Radeon RX 6600]: https://www.xfxforce.com/shop/xfx-speedster-swft-210-amd-radeon-tm-rx-6600-core
[Macbook Pro M1 13"]: https://support.apple.com/en-us/111893
[Determinate Nix Installer]: https://github.com/DeterminateSystems/nix-installer