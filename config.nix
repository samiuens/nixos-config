{
  domain = "samiarda.com";
  timezone = "Europe/Berlin";

  hosts = {
    "smi-nixos" = {
      # System information
      hostname = "smi-nixos";
      platform = "x86_64-linux";
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
        _1password = true;
        coolercontrol = true;
        firefox = true;
        kitty = true;
      };
      # Services
      services = {
        syncthing = true;
        tailscale = true;
      };
    };
  };
}