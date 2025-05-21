{ pkgs, ... }: {
  imports = 
    [
      # Applications
      ../../shared/apps/firefox.nix
      ../apps/aerospace
      ../apps/karabiner
      ../apps/linearmouse
      # Configs
      ../../shared/config/git.nix
      ../../shared/config/shell.nix
    ];
  home.packages = pkgs.callPackage ../packages.nix {};
}