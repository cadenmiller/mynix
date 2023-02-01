# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [
      
      ./hardware-configuration.nix
      
      ../common/users/cullvox
      ../common/global/system.nix
      ../common/global/sound.nix
    ];


  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };

  networking.hostName = "mini";

  environment.sessionVariables = rec {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono"];
    })
  ];

  hardware = {
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  users.users.cullvox = {
    isNormalUser = true;
    description = "Caden Miller";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "abc123";
    packages = with pkgs; [
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some nice packages for the users to get started with.
  environment.systemPackages = with pkgs; [    
    helix
    nitch
    git
    wget
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
