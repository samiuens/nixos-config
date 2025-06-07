{ lib, inputs, myConfig, hostConfig, ... }:
let
  moduleConfig = import ../../lib/loadHostConfigModules.nix { inherit lib; };
in
{
  imports =
    [
      # Flakes and machine-specific import
      inputs.disko.nixosModules.disko
      inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
      ../../hosts/${hostConfig.hostname}

      # Core
      ./core/networking.nix
      ./core/nix.nix
      ./core/security.nix
      ./core/time.nix

      # Users
      ./users

      # Services
      ./services/docker.nix
      ./services/sops.nix
      ./services/ssh.nix
    ]
    ++ (moduleConfig.loadHostConfigModules hostConfig.services ../../services);
}