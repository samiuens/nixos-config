{ hostname, ... }:

let
  services = [ "netdata" "traefik" ];
in
{
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
  ] ++ builtins.map (serviceName: ../../systems/server/services/${serviceName}) services;

  system.stateVersion = "24.11";
}