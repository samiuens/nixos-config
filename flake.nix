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

    /*nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };*/    

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nixpkgs, disko, home-manager, sops-nix, /*nixvim,*/ nix-darwin, nix-homebrew }: 
  let
    myConfig = import ./config.nix;
  
  mkMachine = configName:
    nixpkgs.lib.nixosSystem {
      specialArgs = 
        {
          inherit inputs myConfig;
          hostConfig = myConfig.hosts."${configName}";
        };
      modules = [ ./modules/nixos ];
    };
  mkDarwin = configName:
    nix-darwin.lib.darwinSystem {
      specialArgs = 
        {
          inherit inputs myConfig;
          hostConfig = myConfig.hosts."${configName}";
        };
      modules = [ ./modules/darwin ];
    };
  
  mkServer = configName:
    nixpkgs.lib.nixosSystem {
      specialArgs = 
        {
          inherit inputs myConfig;
          hostConfig = myConfig.servers."${configName}";
        };
      modules = [ ./modules/server ];
    };
  in {
    nixosConfigurations = {
      "smi-nixos"  = mkMachine "smi-nixos";
      "srv-prod-1" = mkServer  "srv-prod-1";
    };
    darwinConfigurations = {
      "smi-mac" = mkDarwin "smi-mac";
    };
  };
}
