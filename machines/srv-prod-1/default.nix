{ hostname, ... }:

let
  services = [ "netdata" "traefik" "sabnzbd" "radarr" "sonarr" "jellyfin" ];
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
    options = [ "users" "uid=0" "gid=0" "umask=0022" "nofail" ];
  };

  system.stateVersion = "24.11";
}