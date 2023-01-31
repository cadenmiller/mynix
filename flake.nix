{
  description = "Caden Miller's NixOS config";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland/v0.19.2beta";
#   nix-gaming.url = "github:fufexan/nix-gaming";
 
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (nixpkgs.lib) filerAttrs;
      inherit (builtins) mapAttrs elem;
      inherit (self) outputs;
      notBroken = x: !(x.meta.broken or false);
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    rec {
    
      nixosConfigurations = rec {
        # Desktop Configuration
        brute = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/brute ];
        };
        # Laptop Configuration
        mini = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/mini ];
        };  
      };
      
      homeConfigurations = {
        # Desktop Configuration
        "cullvox@brute" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/cullvox/brute.nix ];
        };
        # Laptop Configuration
        "cullvox@mini" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/cullvox/mini.nix ];
        };
      };
      
      nixConfig = {
        extra-substituters = [
          "https://cache.m7.rs"
          "https://hyprland.cachix.org"
          "https://nix-community.cachix.org"
        ];
        extra-trusted-public-keys = [
          "cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    };
}
