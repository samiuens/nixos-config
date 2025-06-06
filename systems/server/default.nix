{ config, inputs, hostname, ...}: {
  imports =
    [
      inputs.disko.nixosModules.disko
      inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
      ../shared
      ../../machines/${hostname}

      # Packages
      ./packages.nix

      # Modules
      ./modules/docker.nix
      ./modules/networking.nix
      ./modules/nix.nix
      ./modules/security.nix
      ./modules/sops.nix
      ./modules/ssh.nix
      ./modules/users.nix
    ];
}