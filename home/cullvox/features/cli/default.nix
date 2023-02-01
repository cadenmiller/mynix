{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bc # Calculator on the terminal
    git # Git
  ];
}