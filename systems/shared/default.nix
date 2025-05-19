{ inputs, ... }: {
  imports =
    [
      ./modules/hm.nix
      ./modules/nix.nix
      ./modules/time.nix
      ./modules/users.nix
    ];
}