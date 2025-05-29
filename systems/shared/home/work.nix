{ lib, vars, system, pkgs, ... }: {
  imports = [ ../../${system}/home/work.nix ];
  home = {
    username = "${vars.work.username}";
    homeDirectory = lib.mkDefault [
      (lib.mkIf pkgs.stdenv.isLinux "/home/${vars.work.username}")
      (lib.mkIf pkgs.stdenv.isDarwin "/Users/${vars.work.username}")
    ];
    stateVersion = "25.05";
  };
}
