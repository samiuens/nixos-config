{ pkgs, ... }: {
  imports = 
    [
      # Applications
      ../../shared/apps/firefox.nix
      # Configs
      ../gnome/config.nix
      ../../shared/config/git.nix
    ];
  home.packages = pkgs.callPackage ../packages.nix {};
}