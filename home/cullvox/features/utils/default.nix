{ config, pkgs, ... }:
{
    home.packages = with pkgs; [

        # Some python utilities for waybar's config
        (pkgs.python3.withPackages (ps: [
            ps.requests
        ]))

        python39 # Good old python
        python39Packages.requests # For wttr.in on waybar


        networkmanagerapplet # Makes controlling wpa-enterprise connections on NM easier
        playerctl # Controls pause/play/next on audio/video
        gammastep # Used for brightness control and day/night cycle management
        waybar # Gives some nice bar
        hyprpaper # Gives some nice walls
        wofi # A easy and powerful launcher
        alacritty # Better terminal emulator
        firefox # Synced firefox is very good
        easyeffects # Sound effects for mics/speakers, mostly used for mic suppression

        # UNFREE
        spotify # Good music cannot go away from it
        (discord.override { withOpenASAR = true; nss = pkgs.nss_latest; }) # Better better discord, much more efficent
    ];
    home.sessionVariables = {
        BROWSER = "firefox";
    }
}