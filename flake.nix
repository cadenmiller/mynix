{
  description = "Cullvox's NixOS config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland/v0.19.2beta";
#    nix-gaming.url = "github:fufexan/nix-gaming";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ { self, nixpkgs, utils, home-manager, ... }:
    let
      user = "cullvox";
      # localOverlays = import ./packages/overlays {inherit inputs;};
      # inputOverlays = _: super: {
      # };

    in utils.lib.mkFlake {
      inherit self inputs user;

      channelsConfig.allowUnfree = true;
      # sharedOverlays = [ inputOverlays localOverlays ];

      hostDefaults.extraArgs = { inherit inputs user; };
      hostDefaults.modules = [
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true; # Probably not needed
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit user; };
        }
      ];

      hosts = {
        nixos.modules = [
          ./configuration.nix
          inputs.nixos-hardware.nixosModules.common-cpu-intel-kaby-lake
          inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
          inputs.hyprland.nixosModules.default
          home-manager.nixosModules.home-manager {
            home-manager.users.${user}.imports = [
              ./home.nix
            ];
          }
        ];
      };
  };
}
