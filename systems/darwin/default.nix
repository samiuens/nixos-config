{ inputs, hostname, ... }: {
  imports =
    [
      inputs.home-manager.darwinModules.home-manager
      inputs.nix-homebrew.darwinModules.nix-homebrew
      ../shared
      ../../machines/${hostname}

      # Modules
      ./modules/brew.nix
      ./modules/users.nix

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