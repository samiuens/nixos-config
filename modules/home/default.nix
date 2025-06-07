{ pkgs, lib, myConfig, hostConfig, ... }: {
  home = {
    username = "${hostConfig.user.username}";
    homeDirectory = lib.mkDefault [
      (lib.mkIf pkgs.stdenv.isLinux "/home/${hostConfig.user.username}")
      (lib.mkIf pkgs.stdenv.isDarwin "/Users/${hostConfig.user.username}")
    ];
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;
}
