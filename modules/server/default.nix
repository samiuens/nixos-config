{ lib, inputs, myConfig, hostConfig, ... }:
let
  moduleConfig = import ../../lib/loadHostConfigModules.nix { inherit lib; };
in
{
  imports =
    [
      # Flakes and machine-specific import
      inputs.home-manager.nixosModules.home-manager
      ../../hosts/${hostConfig.hostname}

      # Core
      ./core/

      # Users
      ./users
    ]
    ++ (moduleConfig.loadHostConfigModules hostConfig.services ../../services);
}