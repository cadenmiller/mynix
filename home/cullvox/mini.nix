{ inputs, pkgs, ... }: {
  imports = [
    ./common/global.nix
    ./global
    ./desktop/hyprland
  ];
}