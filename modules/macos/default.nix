{ lib, inputs, myConfig, hostConfig, ... }:
let
  moduleConfig = import ../../lib/loadHostConfigModules.nix { inherit lib; };
in
{
  imports =
    [
      # Flakes and machine-specific import
      inputs.home-manager.darwinModules.home-manager
      ../../hosts/${hostConfig.hostname}

      # Core
      ./core/nix.nix
      ./core/time.nix

      # Settings
      ./settings/appearance.nix
      ./settings/custom.nix
      ./settings/desktop.nix
      ./settings/dock.nix
      ./settings/finder.nix
      ./settings/input.nix
      ./settings/loginwindow.nix
      ./settings/networking.nix
      ./settings/security.nix

      # Users
      ./users
    ]
    ++ (moduleConfig.loadHostConfigModules hostConfig.applications ./applications)
    ++ (moduleConfig.loadHostConfigModules hostConfig.services ./services);
}