# Welcome to my (cullvox's)  nixos config!
# My goal is to create a flake that I can understand, edit and add to down the line. 
#
# This flakes concepts are adapted github:Misterio77's nix flake.
# 
# I have two computers, my laptop (Mini) and my desktop (Brute).
# These are the names of the computers in the config, I don't actually call them that.
#
# First, my laptop has considerably less power than my desktop and any laptop that I may have
# in the future. So I have consolidated what Brute was doing into a better, more understandable
# format for Mini.
#
# Fun fact about Mini: 'Mini's laptop is currently a MacBook Pro 13" Mid 2012 running NixOS'
#
# Brute, my desktop has much more capability than Mini, but I find myself using my laptop
# for most things right now since I am going through college right now. Brute is powerful
# but mistakenly has an Nvidia RTX 2070, and honsetly Nvidia has been getting better with
# Linux things but it still is bad. Brute unfortunately  has to dual boot Windows in order 
# to play games like Warzone 2 because of anticheat problems on linux as well.
#
# Fun fact about Brute: 'It has an Intel Core i5 of some kind, I can't remember'
#
# Those are my computers, and NixOS has to adapt around their hardware. Thats where 'mynix'
# flake had to come in to provide my ultimate computer science nerd functionality onto it.
# Both laptop and desktop now basically running the same software because of NixOS.
#
# I hope that I didn't slip up and let a password or key get in the repo at some point.

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
