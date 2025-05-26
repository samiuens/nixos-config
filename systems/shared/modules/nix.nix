{ username, platform, lib, pkgs, ... }: {
  nix = {
    # Nix daemon is disabled on darwin, because nix-darwin handles it's own.
    enable = lib.mkMerge [
      (lib.mkIf pkgs.stdenv.isLinux true)
      (lib.mkIf pkgs.stdenv.isDarwin false)
    ];
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
      options = "--delete-older-than 7d";
    };
  };
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault "${platform}";
  };
}
