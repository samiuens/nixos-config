{ pkgs, ... }:
  let
    sharedApps = "../../shared/apps"; 
  in
  {
    imports = 
      [
        ${sharedApps}/1password.nix
      ];
    home.packages = pkgs.callPackage ../packages.nix {};
  }