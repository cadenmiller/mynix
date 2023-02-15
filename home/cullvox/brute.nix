{ inputs, pkgs, ... }: {
  imports = [
    ./common/global.nix
    ./global
    ./desktop/hyprland
    #./desktop/hyprland/nvidia.nix
    ./features/programming
    ./features/utils
    ./features/gaming
    ./features/gaming/steam.nix
    ./features/gaming/lutris.nix
  ];
}