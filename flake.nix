{
  description = "samiarda's configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, disko, home-manager, sops-nix }: 
  let
    vars = import ./vars.nix;
  mkServer = name:
    nixpkgs.lib.nixosSystem {
      specialArgs = 
        {
          inherit inputs vars;
          hostname = name;
          username = "samiarda";
          platform = "x86_64-linux";
        };
      modules = [ ./server ];
  };
  in {
    nixosConfigurations = {
      "srv-prod-1" = mkServer "srv-prod-1";
    };
  };
}
