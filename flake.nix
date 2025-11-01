{
  description = "MiTie's NixOS system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      mitie-tueai = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/mitie-tueai/configuration.nix
        ];
      };
    };
  };
}
