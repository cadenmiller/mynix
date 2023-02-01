{ pkgs, inputs, lib, config, ... }:
{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
    package = pkgs.nixUnstable;
  };
}
