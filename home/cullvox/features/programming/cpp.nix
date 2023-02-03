{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode.fhs

    gcc
    cmake
  ];
}