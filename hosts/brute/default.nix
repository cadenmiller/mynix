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

  # Boot information
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

  # Set our hostname here, instead of globally
  networking.hostName = "brute";

  environment.sessionVariables = rec {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono"];
    })
  ];

  # Hardware options
  hardware = {
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia.open = true;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  users.users.cullvox = {
    isNormalUser = true;
    description = "Caden Miller";
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPassword = "$y$j9T$Z9ch6k8.kDRQ3XtqvmY47/$CgI41fvLMnoXbXqyrOR956K7emReG5QiAzFCKcr92n6";
    packages = with pkgs; [
    ];
  };

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some nice packages for the users to get started with.
  environment.systemPackages = with pkgs; [    
    helix
    nitch
    git
    wget
    canon-cups-ufr2
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
