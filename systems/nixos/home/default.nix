{ pkgs, ... }:
  let
    sharedApps = "../../shared/apps"; 
  in 
  {
    imports = [];
    home.packages = pkgs.callPackage ../packages.nix {};
  }