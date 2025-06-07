{ lib, inputs, config, hostConfig, ... }:
let
  apps = import ../../lib/loadHostConfigApplications.nix { inherit lib; };
in
{
  imports =
    [
      # Flakes and machine-specific import
      inputs.home-manager.nixosModules.home-manager
      ../../hosts/${hostConfig.hostname}

      # Core
      ./core/audio.nix
      ./core/bluetooth.nix
      ./core/boot.nix
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
        then ./desktop-environment/gnome
        /*else if myConfig.databaseType == "hyprland"
        then ./desktop-environment/hyprland*/
        else throw "unknown desktop environment (${hostConfig.hostname}): ${hostConfig.desktopEnvironment}"
      )

      # Applications
      (apps.loadHostConfigApplications hostConfig.applications ./applications)
    ];
}