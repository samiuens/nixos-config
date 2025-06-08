{ hostConfig, pkgs, ... }: {
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
    casks = pkgs.callPackage ../../../packages/${hostConfig.os}/casks.nix {};
    masApps = {
      "Bitwarden" = 1352778147;
    };
  };
  
  nix-homebrew = {
    enable = true;
    enableRosetta = if (hostConfig.platform == "aarch64-darwin") then true else false;
    autoMigrate = true;
    user = "${hostConfig.user.username}";
    mutableTaps = true;
  };
}
