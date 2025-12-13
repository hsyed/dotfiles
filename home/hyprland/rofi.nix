{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = "gruvbox-dark";
    plugins = [ ];
  };
}
