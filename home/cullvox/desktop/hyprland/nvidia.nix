{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  wayland.windowManager.hyprland = {
    nvidiaPatches = true;
  }
}
