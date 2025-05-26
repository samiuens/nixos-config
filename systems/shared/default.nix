{ inputs, ... }: {
  imports =
    [
      # Modules
      ./modules/fonts.nix
      ./modules/hm.nix
      ./modules/nix.nixd
      ./modules/time.nix
      ./modules/users.nix
    ];
}