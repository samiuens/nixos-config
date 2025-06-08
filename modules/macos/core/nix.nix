{ hostConfig, lib, ... }: {
  nix = {
    enable = false; # nix-darwin manages its own nix daemon
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
      allowBroken = true; # allow broken packages, only on 'aarch64-darwin'
    };
    hostPlatform = lib.mkDefault "${hostConfig.platform}";
  };
}
