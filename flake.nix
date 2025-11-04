{
  description = "MiTie's NixOS system and home-manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      mitie-tueai = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/mitie-tueai/configuration.nix
          ./modules/common.nix
          sops-nix.nixosModules.sops
        ];
      };
    };
    
    homeConfigurations = {
      "mitiemann@mitie-tueai" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home/common.nix
          sops-nix.homeManagerModules.sops
        ];
      };
    };
    
  };
}
