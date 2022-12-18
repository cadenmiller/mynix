{ lib, config, pkgs, user, ... }: 
{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "22.11";
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };
}