{ ...}: {
  imports =
    [
      ./disk-config.nix
      ./hardware-configuration.nix
    ];
  #system.stateVersion = 24.11;
}