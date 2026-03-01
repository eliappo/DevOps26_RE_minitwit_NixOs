{
  description = "Minitweet NixOS deployment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, ... }:
    {
      nixosConfigurations = {
        minitweet-db = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./nix-hosts/db/configuration.nix
            ./modules/disk.nix
            ./modules/postgres.nix
          ];
        };

        minitweet-api = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./nix-hosts/app/configuration.nix
            ./modules/disk.nix
            ./modules/minitwit-app.nix
          ];
        };
      };
    };
}
