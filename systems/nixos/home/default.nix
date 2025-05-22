{ pkgs, ... }: {
  imports = 
    [
      # Applications
      ../../shared/apps/firefox.nix
      # Configs
      ../gnome/config.nix
      ../../shared/config/git.nix
      ../../shared/config/shell
    ];
  home.packages = pkgs.callPackage ../packages.nix {};
}