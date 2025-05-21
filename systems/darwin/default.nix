{ inputs, hostname, ... }: {
  imports =
    [
      inputs.home-manager.darwinModules.home-manager
      ../shared
      ../../machines/${hostname}

      # System settings
      ./system/appearance.nix
      ./system/custom.nix
      ./system/desktop.nix
      ./system/dock.nix
      ./system/finder.nix
      ./system/input.nix
      ./system/loginwindow.nix
      ./system/networking.nix
      ./system/security.nix
    ];
}