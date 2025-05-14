{ username, platform, lib, ... }: {
  nix = {
    enable = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.trusted-users = [ "${username}" ];
    optimise = {
      automatic = true;
      dates = [ "daily" ];
    };
    gc = {
      automatic = true;
      dates = [ "daily" ];
      options = "--delete-older-than 7d";
    };
  };
  nixpkgs = {
    config.allowUnfree = true;
    config.allowBroken = true;
    hostPlatform = lib.mkDefault "${platform}";
  };
}
