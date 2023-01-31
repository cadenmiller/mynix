{ pkgs, config, lib, outputs, ... }:
{
  users.mutableUsers = false;
  users.users.cullvox = {
    isNormalUser = true;
    initialPassword = "abc123";
    extraGroups = [
      "wheel"
    ];
    packages = [ pkgs.home-manager ];
  };
}
