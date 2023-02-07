{ pkgs, ... }:
{
    home.packages = with pkgs; [
        prismlauncher
        lunar-client
        dolphin-emu-beta
    ];
}