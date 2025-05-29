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
    ];
}