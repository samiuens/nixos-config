{ inputs, pkgs, ... }: {
  imports = 
    [
      # Inputs
      inputs.nixvim.homeModules.nixvim
      # Applications
      ../../shared/apps/firefox.nix
      ../../shared/apps/kitty.nix
      ../../shared/apps/syncthing.nix
      
      ../apps/aerospace
      ../apps/karabiner
      ../apps/linearmouse
      # Configs
      ../../shared/config/shell
      #../../shared/config/git.nix
      ../../shared/config/ssh.nix
      ../../shared/config/gpg
      # Quirks
      ./firefox-fix.nix
    ];
  home.packages = pkgs.callPackage ../packages.nix {};
}