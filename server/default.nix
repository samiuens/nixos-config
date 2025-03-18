{ config, inputs, hostname, ...}: {
  imports =
    [
      inputs.disko.nixosModules.disko
      inputs.home-manager.darwinModules.home-manager
      ./shared
      ./${hostname}
    ];
}