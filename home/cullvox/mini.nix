{ inputs, pkgs, ... }: {
  imports = [
    ./common/global.nix
    ./desktop/hyprland
  ];
}