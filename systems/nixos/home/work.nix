{ pkgs, ... }: {
  imports = 
    [
      # Applications
      ../../shared/apps/kitty.nix
      # Configs
      ../gnome/config.nix
      ../../shared/config/shell
    ];
  home.packages = with pkgs; [
    google-chrome
    bitwarden-desktop
    code-cursor
    jetbrains.datagrip
    gitkraken
    nest-cli
    awscli2
    nodejs_24
    typescript
    signal-desktop
  ];
}