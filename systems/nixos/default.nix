{ inputs, hostname, ... }: {
  imports =
    [
      #inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
      ../shared
      ../../machines/${hostname}

      # Hardware
      ./hardware/bluetooth.nix
      ./hardware/printing.nix
      ./hardware/sound.nix

      # Modules
      ./modules/boot.nix
      ./modules/locale.nix
      ./modules/networking.nix
      ./modules/security.nix
      ./modules/users.nix

      # Gnome
      ./gnome/xserver.nix
      ./gnome/debloat.nix
      ./gnome/extensions.nix

      # Applications
      ../shared/apps/1password.nix
    ];
}