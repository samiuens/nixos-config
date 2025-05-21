{ lib, username, system, pkgs, ... }: {
  imports = [ ../../${system}/home ];
  home = {
    username = "${username}";
    homeDirectory = lib.mkMerge [
      (lib.mkIf pkgs.stdenv.isLinux "/home/${username}")
      (lib.mkIf pkgs.stdenv.isDarwin "/Users/${username}")
    ];
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;
}
