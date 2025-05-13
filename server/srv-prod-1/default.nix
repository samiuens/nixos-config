{ hostname, ... }:

let
  services = [ "" ];
in
{
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
  ] ++ builtins.map (serviceName: ../../services/${serviceName}.nix) services;
  #] ++ builtins.map (serviceName: ../../services/${serviceName}.nix { inherit hostname; }) services;

  # system.stateVersion = 24.11;
}