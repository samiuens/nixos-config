{
  description = "samiarda's server configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
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
  };

  outputs = inputs@{ self, nixpkgs, disko, home-manager, sops-nix }: 
  let
    baseDomain = "samiarda.com";
  in {
    nixosConfigurations = {
      "srv-prod-1" = nixpkgs.lib.nixosSystem {
        specialArgs =
          {
            inherit inputs baseDomain;
            hostname = "srv-prod-1";
            username = "samiarda";
            platform = "x86_64-linux";
          };
        modules = [
          ./server
        ];
      };
    };
  };
}
