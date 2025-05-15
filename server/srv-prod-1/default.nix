{ hostname, ... }:

let
  services = [ "traefik" ];
in
{
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
  ] ++ builtins.map (serviceName: ../../services/${serviceName}) services;
  #] ++ builtins.map (serviceName: ../../services/${serviceName} { inherit hostname; }) services;

  system.stateVersion = "24.11";
}