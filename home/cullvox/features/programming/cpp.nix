{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode.fhs

    gcc
    cmake
    ninja

    vulkan-headers
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    glslang
  ];
}