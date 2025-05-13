{ config, inputs, hostname, ...}: {
  imports =
    [
      inputs.disko.nixosModules.disko
      inputs.home-manager.darwinModules.home-manager
      inputs.sops-nix.nixosModules.sops
      ./shared
      ./${hostname}
    ];
}