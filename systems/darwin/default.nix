{ inputs, hostname, ... }: {
  imports =
    [
      #inputs.sops-nix.nixosModules.sops
      inputs.home-manager.darwinModules.home-manager
      ../shared
      ../../machines/${hostname}

      # Config
      ./config/appearance.nix
      ./config/custom.nix
      ./config/desktop.nix
      ./config/dock.nix
      ./config/finder.nix
      ./config/input.nix
      ./config/loginwindow.nix
      ./config/networking.nix
      ./config/security.nix
    ];
}