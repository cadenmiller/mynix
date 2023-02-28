{ inputs, lib, pkgs, ... }: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      hidpi = true;
    };
    nvidiaPatches = true;
    extraConfig = (import ./config.nix);
  };
  
}