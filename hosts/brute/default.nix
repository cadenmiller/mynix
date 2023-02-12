# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [
      ./hardware-configuration.nix
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

  networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.openssh.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  hardware = {
    steam-hardware.enable = true;
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  environment.sessionVariables = rec {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  
  programs = {
    steam = {
      enable = true;
    };
    gamemode = {
      enable = true;
      settings = {
        general = {
          reaper_freq = 5;
          defaultgov = "performance";
          softrealtime = "auto";
          renice = 0;
          ioprio = 0;          
        };
      };
    };
  };

  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  users.users.cullvox = {
    isNormalUser = true;
    description = "Caden Miller";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      xterm
      alacritty
      waybar
      hyprpaper
      wget
      libsForQt5.breeze-icons
      libsForQt5.ark
      dolphin
                               
      # Building and Compiling Tools
      git
      gnumake
      gcc
      cmake

      # File Editing and Word Processing
      helix
      libreoffice-fresh
      hunspell
      blender
      gimp
      darktable
      celluloid
      obs-studio
      davinci-resolve

      # Internet and Communication
      spotify
      firefox
      cinny
      ledger-live-desktop

      (discord.override { 
        withOpenASAR = true; 
        nss = pkgs.nss_latest; 
      })
              
      # Sound and Audio
      easyeffects
      
      # Gaming and Entertainment
      steam
      steam-run
      grapejuice
      lutris
      prismlauncher
      lunar-client
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  environment.systemPackages = with pkgs; [
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
