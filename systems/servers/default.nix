{ config, inputs, hostname, ...}: {
  imports =
    [
      inputs.disko.nixosModules.disko
      inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
      ../shared
      ../../machines/${hostname}
    ];
}