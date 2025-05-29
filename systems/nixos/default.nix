{ inputs, hostname, work, lib, ... }: {
  imports =
    [
      #inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
      ../shared
      ../../machines/${hostname}

      # Hardware
      ./hardware/bluetooth.nix
      ./hardware/fans.nix
      ./hardware/printing.nix
      ./hardware/sound.nix

      # Modules
      ./modules/boot.nix
      ./modules/locale.nix
      ./modules/networking.nix
      ./modules/nix.nix
      ./modules/security.nix
      ./modules/tailscale.nix
      ./modules/users.nix

      # Gnome
      ./gnome/xserver.nix
      ./gnome/debloat.nix
      ./gnome/extensions.nix

      # Applications
      ../shared/apps/1password.nix
    ];
}