{ pkgs, ... }: {
  imports = 
    [
      # Applications
      # Configs
      ../../shared/config/git.nix
    ];
  home.packages = pkgs.callPackage ../packages.nix {};
}