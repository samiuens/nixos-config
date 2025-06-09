{ pkgs, lib, myConfig, hostConfig, ... }:
let
  moduleConfig = import ../../lib/loadHostConfigModules.nix { inherit lib; };
in
{
  imports =
    []
    ++ (moduleConfig.loadHostConfigModules hostConfig.applications ./applications "personal")
    ++ (moduleConfig.loadHostConfigModules hostConfig.services ./services "personal")
    ++ (moduleConfig.loadHostConfigModules hostConfig.configs ./configs "personal")
    ++ (lib.optional (hostConfig.os == "nixos") ./desktop/${hostConfig.desktopEnvironment});


  home = {
    username = "${hostConfig.user.username}";
    homeDirectory = lib.mkDefault [
      (lib.mkIf pkgs.stdenv.isLinux "/home/${hostConfig.user.username}")
      (lib.mkIf pkgs.stdenv.isDarwin "/Users/${hostConfig.user.username}")
    ];
    stateVersion = "25.05";
    packages = pkgs.callPackage ../../packages/${hostConfig.os}/packages.nix {};
  };
  programs.home-manager.enable = true;
}
