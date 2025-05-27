{ hostname, ... }:

let
  services = [ 
    "netdata"
    "tailscale"
    "traefik"
    "sabnzbd"
    "radarr"
    "sonarr"
    "jellyfin"
    "jellyseerr"
  ];
in
{
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
  ] ++ builtins.map (serviceName: ../../systems/server/services/${serviceName}) services;

  # Mount external hard drive for media storage;
  fileSystems."/mnt/media" = {
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