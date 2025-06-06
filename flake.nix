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

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };    

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nixpkgs, disko, home-manager, sops-nix, nixvim, nix-darwin, nix-homebrew }: 
  let
    vars = import ./vars.nix;
  
  mkMachine = name: workEnabled:
    nixpkgs.lib.nixosSystem {
      specialArgs = 
        {
          inherit inputs vars;
          hostname = name;
          username = "samiuensay";
          platform = "x86_64-linux";
          system = "nixos";
          work = workEnabled;
        };
      modules = [ ./systems/nixos ];
    };
  mkDarwin = name: workEnabled:
    nix-darwin.lib.darwinSystem {
      specialArgs = 
        {
          inherit inputs vars;
          hostname = name;
          username = "samiuensay";
          platform = "aarch64-darwin";
          system = "darwin";
          work = workEnabled;
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
      # Machines: "hostname" = mkMachine "hostname" workProfile?;
      "smi-nixos"  = mkMachine "smi-nixos" true;

      # Servers: "hostname" = mkServer "hostname";
      "srv-prod-1" = mkServer  "srv-prod-1";
    };
    darwinConfigurations = {
      # Macs: "hostname" = mkDarwin "hostname" workProfile?;
      "smi-mac" = mkDarwin "smi-mac" true;
    };
  };
}
