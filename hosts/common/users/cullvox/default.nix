{ pkgs, config, lib, outputs, ... }:
{
  users.mutableUsers = false;
  users.users.cullvox = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$Z9ch6k8.kDRQ3XtqvmY47/$CgI41fvLMnoXbXqyrOR956K7emReG5QiAzFCKcr92n6";
    extraGroups = [
      "wheel"
    ];
    packages = [ pkgs.home-manager ];
  };
}
