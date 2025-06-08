{ hostConfig, lib, ... }: {
  nix = {
    enable = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.trusted-users = [ "${hostConfig.user.username}" ];
    optimise = {
      automatic = true;
      dates = [ "daily" ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 3d";
    };
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
    };
    hostPlatform = lib.mkDefault "${hostConfig.platform}";
  };
}
