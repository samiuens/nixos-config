{ username, platform, lib, ... }: {
  nix = {
    enable = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.trusted-users = [ "${username}" ];
  };
  nixpkgs = {
    config.allowUnfree = true;
    config.allowBroken = true;
    hostPlatform = lib.mkDefault "${platform}";
  };
}
