{ config, pkgs, ... }:
{
    home.packages = with pkgs; [

        # Some python utilities for waybar's config
        (pkgs.python3.withPackages (ps: [
            ps.requests
        ]))

        #python39 # Good old python
        #python39Packages.requests # For wttr.in on waybar

        xdg-utils
        
        pass

        networkmanagerapplet # Makes controlling wpa-enterprise connections on NM easier
        playerctl # Controls pause/play/next on audio/video
        gammastep # Used for brightness control and day/night cycle management
        waybar # Gives some nice bar
        swaybg # Gives some nice walls
        wofi # A easy and powerful launcher
        alacritty # Better terminal emulator
        firefox # Synced firefox is very good
        easyeffects # Sound effects for mics/speakers, mostly used for mic suppression
        #libreoffice-fresh # Word processor, Presentation software and more
        helvum # Pipewire viewer and editor
        pavucontrol # Pulse Audio/Pipewire audio control gui program
        element-desktop # Matrix communicator and better alternative to discord
        #jdk18
        ventoy-bin # Easily create flash drives that can launch isos
        spotify-tui

        # UNFREE
        # spotify # Good music cannot go away from it
        zoom-us
        (discord.override { withOpenASAR = true; }) # Better better discord, much more efficent
    ];
    services.spotifyd = {
        enable = true;
    };
    xdg.configFile."spotifyd" = {
        source = ./spotifyd;
        recursive = true;
    };
}