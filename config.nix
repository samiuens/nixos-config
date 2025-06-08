{
  domain = "samiarda.com";
  timezone = "Europe/Berlin";

  hosts = {
    "smi-nixos" = {
      # System information
      hostname = "smi-nixos";
      platform = "x86_64-linux";
      os = "nixos";
      
      # Desktop
      desktopEnvironment = "gnome";
      
      # Personal user
      user = {
        name = "Sami Arda Ünsay";
        username = "samiuensay";
      };
      # Work user
      /*workUser = {
        name = "Sami Arda Ünsay";
        username = "samiarda";
      };*/

      # Applications
      applications = {
        coolercontrol = true;
        firefox = true;
        kitty = true;
        onepassword = true;
      };
      # Services
      services = {
        syncthing = true;
        tailscale = true;
      };
      # Configs
      configs = {
        shell = true;
        git = true;
        gpg = true;
        ssh = true;
      };
    };
  };

  servers = {
    "srv-prod-1" = {
      # Host information
      hostname = "srv-prod-1";
      platform = "x86_64-linux";
      os = "server";

      # User
      user = {
        name = "Sami Arda Ünsay";
        username = "samiarda";
      };

      applications = {};
      services = {};
      configs = {
        shell = true;
        git = true;
      };

      services = {
        netdata = true;
        tailscale = true;
        traefik = true;
        homepage = false; # TODO: outstanding configuration
        sabnzbd = true;
        radarr = true;
        sonarr = true;
        bazarr = true;
        jellyfin = true;
        jellyseerr = true;
      };
    };
  };
}