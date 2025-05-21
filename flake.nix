{
  description = "samiarda's configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, disko, home-manager, sops-nix, nix-darwin }: 
  let
    vars = import ./vars.nix;
  
  mkMachine = name:
    nixpkgs.lib.nixosSystem {
      specialArgs = 
        {
          inherit inputs vars;
          hostname = name;
          username = "samiuensay";
          platform = "x86_64-linux";
          system = "nixos";
        };
      modules = [ ./systems/nixos ];
    };
  mkDarwinMachine = name:
    nix-darwin.lib.darwinSystem {
      specialArgs = 
        {
          inherit inputs vars;
          hostname = name;
          username = "samiuensay";
          platform = "x86_64-linux";
          system = "darwin";
        };
      modules = [ ./systems/darwin ];
    };
  
  mkServer = name:
    nixpkgs.lib.nixosSystem {
      specialArgs = 
        {
          inherit inputs vars;
          hostname = name;
          username = "samiarda";
          platform = "x86_64-linux";
          system = "server";
        };
      modules = [ ./systems/server ];
    };
  in {
    nixosConfigurations = {
      "smi-nixos"  = mkMachine "smi-nixos";
      "srv-prod-1" = mkServer  "srv-prod-1";
    };
    darwinConfigurations = {
      "smi-macbook" = mkDarwinMachine "smi-macbook";
    };
  };
}
