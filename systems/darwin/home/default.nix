{ pkgs, ... }: {
  imports = 
    [
      # Applications
      ../../shared/apps/firefox.nix
      # Configs
      ../../shared/config/git.nix
    ];
  home.packages = pkgs.callPackage ../packages.nix {};
}