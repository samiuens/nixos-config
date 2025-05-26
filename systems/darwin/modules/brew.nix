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
    brews = [];
    casks = [
      # create
      "obsidian"
      "anki"

      # consume
      "firefox"

      # hosting
      "termius"

      # security
      "1password"
      "yubioath-flutter"
      "cryptomator"
    ];
    masApps = {};
  };
  
  nix-homebrew = {
    enable = true;
    enableRosetta = if (platform == "aarch64-darwin") then true else false;
    autoMigrate = true;
    user = "${username}";
    mutableTaps = true;
  };
}
