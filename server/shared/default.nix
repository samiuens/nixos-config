{ ... }: {
  imports =
    [
      ./modules/hm.nix
      ./modules/docker.nix
      ./modules/network.nix
      ./modules/security.nix
      ./modules/ssh.nix
      ./modules/time.nix
      ./modules/users.nix
    ];
}
