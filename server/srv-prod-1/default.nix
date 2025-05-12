{ ...}: {
  imports =
    [
      ./disk-config.nix
      ./hardware-configuration.nix

      # services
    ];
  #system.stateVersion = 24.11;
}