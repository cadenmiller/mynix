{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bc # Calculator on the terminal
    git # Git
    unzip # Unzip downloaded files
    zip # Zip and compress files
  ];
}