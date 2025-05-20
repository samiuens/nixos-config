{ pkgs, ... }: {
  imports = 
    [
      # Applications
      # Configs
      ../gnome/config.nix
      ../../shared/configs/git.nix
    ];
  home.packages = pkgs.callPackage ../packages.nix {};
}