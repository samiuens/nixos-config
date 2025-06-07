{ pkgs, lib, myConfig, hostConfig, ... }:
let
  moduleConfig = import ../../lib/loadHostConfigModules.nix.nix { inherit lib; };
in
{
  imports =
    []
    ++ (moduleConfig.loadHostConfigModules hostConfig.hmApplications ./applications)
    ++ (moduleConfig.loadHostConfigModules hostConfig.services ./services);


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
