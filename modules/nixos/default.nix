{ lib, inputs, myConfig, hostConfig, ... }:
let
  moduleConfig = import ../../lib/loadHostConfigModules.nix { inherit lib; };
in
{
  imports =
    [
      # Flakes and machine-specific import
      inputs.home-manager.nixosModules.home-manager
      inputs.lanzaboote.nixosModules.lanzaboote
      #inputs.nixvim.homeModules.nixvim
      ../../hosts/${hostConfig.hostname}

      # Core
      ./core/audio.nix
      ./core/bluetooth.nix
      ./core/boot.nix
      ./core/fonts.nix
      ./core/locale.nix
      ./core/networking.nix
      ./core/nix.nix
      ./core/printing.nix
      ./core/security.nix
      ./core/time.nix

      # Users
      ./users

      # Desktop Environments
      (if hostConfig.desktopEnvironment == "gnome"
        then ./desktop/gnome
        /*else if myConfig.databaseType == "hyprland"
        then ./desktop/hyprland*/
        else throw "unknown desktop environment (${hostConfig.hostname}): ${hostConfig.desktopEnvironment}"
      )
    ]
    ++ (moduleConfig.loadHostConfigModules hostConfig.applications ./applications "personal")
    ++ (moduleConfig.loadHostConfigModules hostConfig.services ./services "personal")
    ++ (moduleConfig.loadHostConfigModules hostConfig.applications ./applications "work")
    ++ (moduleConfig.loadHostConfigModules hostConfig.services ./services "work");
}