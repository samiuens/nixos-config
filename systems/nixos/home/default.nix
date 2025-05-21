{ pkgs, ... }: {
  imports = 
    [
      # Applications
      # Configs
      ../gnome/config.nix
      ../../shared/config/git.nix
    ];
  home.packages = pkgs.callPackage ../packages.nix {};
}