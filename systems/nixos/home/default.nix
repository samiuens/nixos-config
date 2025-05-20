{ pkgs, ... }:
  let
    sharedApps = "../../shared/apps"; 
  in
  {
    imports = 
      [
        # Applications
        # Configs
        ../../shared/configs/git.nix
      ];
    home.packages = pkgs.callPackage ../packages.nix {};
  }