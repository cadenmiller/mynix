{ inputs, pkgs, ... }: {
  imports = [
    ./common/global.nix
    ./global
    ./desktop/hyprland
    ./features/programming
    ./features/utils
    ./features/gaming
  ];
}