{ config, pkgs, ... }:
{
  imports = [
    ./vscode.nix
    ./cpp.nix
  ];
}
