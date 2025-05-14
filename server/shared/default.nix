{ ... }: {
  imports =
    [
      ./modules/docker.nix
      ./modules/hm.nix
      ./modules/networking.nix
      ./modules/nix.nix
      ./modules/security.nix
      ./modules/sops.nix
      ./modules/ssh.nix
      ./modules/time.nix
      ./modules/users.nix
    ];
}
