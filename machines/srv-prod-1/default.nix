{ hostname, ... }:

let
  services = [ 
    "netdata"
    "tailscale"
    "traefik"
    "homepage"
    "sabnzbd"
    "radarr"
    "sonarr"
    "bazarr"
    "jellyfin"
    "jellyseerr"
  ];
in
{
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
  ] ++ builtins.map (serviceName: ../../systems/server/services/${serviceName}) services;

  # Mount external hard drive for data storage
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/78f433f8-4560-428f-bd3f-df9872a53706";
    fsType = "ext4";
    options = [
      "defaults"
      "users"
      "nofail"
    ];
  };

  system.stateVersion = "24.11";
}