{ config, inputs, hostname, ...}: {
  imports =
    [
      inputs.disko.nixosModules.disko
      inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
      ../shared
      ../../machines/${hostname}

      # Home Manager
      ./home

      # Modules
      ./modules/docker.nix
      ./modules/networking.nix
      ./modules/packages.nix
      ./modules/security.nix
      ./modules/sops.nix
      ./modules/ssh.nix
      ./modules/users.nix
    ];
}