{ pkgs, ... }: {
  imports = 
    [
      # Applications
      ../../shared/apps/kitty.nix
      # Configs
      ../gnome/config.nix
      ../../shared/config/shell
    ];
}