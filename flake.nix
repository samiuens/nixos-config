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
  };

  outputs = inputs@{ self, nixpkgs, disko }: {
    nixosConfigurations = {
      "srv-prod-1" = nixpkgs.lib.nixosSystem {
        specialArgs =
          {
            inherit inputs;
            hostname = "srv-prod-1";
            username = "samiarda";
            platform = "x86_64-linux";
          };
        modules = [
          ./server
        ];
      }
    }
  };
}
