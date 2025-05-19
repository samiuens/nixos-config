{ inputs, ... }: {
  imports =
    [
      # Modules
      ./modules/fonts.nix
      ./modules/hm.nix
      ./modules/networking.nix
      ./modules/nix.nix
      ./modules/time.nix
      ./modules/users.nix
    ];
}