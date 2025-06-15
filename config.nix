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
      workUser = {
        enabled = true;
        name = "samiarda";
        username = "samiarda";
      };

      # Applications
      applications = {
        coolercontrol = {
          personal = true;
          work = true;
        };
        firefox = {
          personal = true;
          work = false;
        };
        kitty = {
          personal = true;
          work = true;
        };
        onepassword = {
          personal = true;
          work = false;
        };
      };
      # Services
      services = {
        syncthing = {
          personal = true;
          work = false;
        };
        tailscale = {
          personal = true;
          work = true;
        };
        docker = {
          personal = true;
          work = true;
        };
        podman = {
          personal = false;
          work = true;
        };
      };
      # Configs
      configs = {
        shell = {
          personal = true;
          work = true;
        };
        git = {
          personal = true;
          work = false;
        };
        gpg = {
          personal = true;
          work = false;
        };
        ssh = {
          personal = true;
          work = false;
        };
      };
    };

    "smi-mac" = {
      # System information
      hostname = "smi-mac";
      platform = "aarch64-darwin";
      os = "macos";
      
      # Personal user
      user = {
        name = "Sami Arda Ünsay";
        username = "samiuensay";
      };
      # Work user
      workUser = {
        enabled = true;
        name = "samiarda";
        username = "samiarda";
      };

      # Applications
      applications = {
        aerospace = {
          personal = true;
          work = true;
        };
        firefox = {
          personal = true;
          work = false;
        };
        karabiner-elements = {
          personal = true;
          work = true;
        };
        kitty = {
          personal = true;
          work = true;
        };
        linearmouse = {
          personal = true;
          work = true;
        };
        onepassword = {
          personal = false;
          work = false;
        };
      };
      # Services
      services = {
        syncthing = {
          personal = true;
          work = false;
        };
        tailscale = {
          personal = true;
          work = true;
        };
        docker = {
          personal = true;
          work = true;
        };
      };
      # Configs
      configs = {
        shell = {
          personal = true;
          work = true;
        };
        git = {
          personal = true;
          work = false;
        };
        gpg = {
          personal = true;
          work = false;
        };
        ssh = {
          personal = true;
          work = false;
        };
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
        netdata = false;
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