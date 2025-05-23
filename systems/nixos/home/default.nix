{ pkgs, ... }: {
  imports = 
    [
      # Applications
      ../../shared/apps/firefox.nix
      ../../shared/apps/kitty.nix
      # Configs
      ../gnome/config.nix
      ../../shared/config/git.nix
      ../../shared/config/shell
      ../../shared/config/gpg
    ];
  home.packages = pkgs.callPackage ../packages.nix {};
}