# System settings that are usually the same across systems.
# This means enabling services, timezones, locales...

{ pkgs, ... }: {

  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPorts = [
      3074
    ];
  };

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.utf8";

  services.printing.enable = true;

}