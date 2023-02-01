{ lib, inputs, outputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./nix.nix
    ./python.nix
  ];
}
