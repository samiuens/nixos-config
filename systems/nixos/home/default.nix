{ pkgs, ... }: {
  imports = 
    [
      # Applications
      ../../shared/apps/firefox.nix
      ../../shared/apps/kitty.nix
      ../../shared/apps/syncthing.nix
      # Configs
      ../gnome/config.nix
      ../../shared/config/shell
      ../../shared/config/git.nix
      ../../shared/config/ssh.nix
      ../../shared/config/gpg
    ];
  home.packages = pkgs.callPackage ../packages.nix {};
}