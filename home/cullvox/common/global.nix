{ inputs, lib, pkgs, config, outputs, ... }:
{
  programs = {
    home-manager.enable = true;
    git.enable = true;
  }
}
