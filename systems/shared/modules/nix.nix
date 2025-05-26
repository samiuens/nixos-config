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
  };
  nixpkgs = {
    config.allowUnfree = true;
    config.allowBroken = if (platform == "aarch64-darwin") then true else false;
    hostPlatform = lib.mkDefault "${platform}";
  };
}
