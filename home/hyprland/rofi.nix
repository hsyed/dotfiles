{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = "gruvbox-dark";
    plugins = [
      pkgs.rofi-emoji
    ];
  };
}
