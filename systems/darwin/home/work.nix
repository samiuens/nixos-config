{ pkgs, ... }: {
  imports = 
    [
      # Applications
      ../../shared/apps/kitty.nix
      
      ../apps/aerospace
      ../apps/karabiner
      ../apps/linearmouse
      # Configs
      ../../shared/config/shell
    ];
  home.packages = with pkgs; [
    google-chrome
    code-cursor
    jetbrains.datagrip
    gitkraken
    nest-cli
    awscli2
    nodejs_24
    typescript
    mkcert
    podman
    podman-compose
    aerospace
  ];
}