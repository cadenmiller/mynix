{ pkgs, ...}:
{
  home.packages = with pkgs; [
    lutris
    dxvk
  ];
}