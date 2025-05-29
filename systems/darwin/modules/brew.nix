{ username, platform, ... }: {
  environment.variables.HOMEBREW_NO_ANALYTICS = "1";

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = false;
      cleanup = "zap";
    };
    taps = [];
    brews = [
      "mas"
      "openssh"
    ];
    casks = [
      # create
      "obsidian"
      "anki"
      "google-drive"

      # communication
      "signal"
      
      # consume
      "firefox"

      # hosting
      "termius"
      
      # development
      "trae"
      "orbstack"

      # security
      "1password"
      "yubico-authenticator"
      "cryptomator"

      # utils
      "raycast"
      "linearmouse"
      "cleanshot"
      "karabiner-elements"
      "jordanbaird-ice"
      "tailscale"
    ];
    masApps = {
      "Bitwarden" = 1352778147;
    };
  };
  
  nix-homebrew = {
    enable = true;
    enableRosetta = if (platform == "aarch64-darwin") then true else false;
    autoMigrate = true;
    user = "${username}";
    mutableTaps = true;
  };
}
