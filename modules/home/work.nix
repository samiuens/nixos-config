{ pkgs, lib, myConfig, hostConfig, ... }:
let
  moduleConfig = import ../../lib/loadHostConfigModules.nix { inherit lib; };
in
{
  imports =
    []
    ++ (moduleConfig.loadHostConfigModules hostConfig.applications ./applications)
    #++ (moduleConfig.loadHostConfigModules hostConfig.services ./services)
    ++ (moduleConfig.loadHostConfigModules hostConfig.configs ./configs)
    ++ (lib.optional (hostConfig.os == "nixos") ./desktop/${hostConfig.desktopEnvironment});


  home = {
    username = "${hostConfig.workUser.username}";
    homeDirectory = lib.mkDefault [
      (lib.mkIf pkgs.stdenv.isLinux "/home/${hostConfig.workUser.username}")
      (lib.mkIf pkgs.stdenv.isDarwin "/Users/${hostConfig.workUser.username}")
    ];
    stateVersion = "25.05";
    packages = pkgs.callPackage ../../packages/work.nix {};
  };
  programs.home-manager.enable = true;
}
