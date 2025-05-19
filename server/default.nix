{ config, inputs, hostname, ...}: {
  imports =
    [
      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.home-manager
      inputs.sops-nix.nixosModules.sops
      ./shared
      ./${hostname}
    ];
}