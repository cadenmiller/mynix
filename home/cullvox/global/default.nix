
{ inputs, lib, pkgs, config, outputs, ... }:
{
  imports = [
    inputs.nmpermanence.nixosModules.home-manager-impermanence
    ../features/cli
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "cullvox";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "22.05";

    persistence = {
      "/persist/home/cullvox" = {
        directories = [
          "Documents"
          "Downloads"
          "Pictures"
          "Videos"
        ];
        allowOther = true;
      };
    };
  };

}