{ pkgs, ... }:
{
  programs.wofi = {
    enable = true;
    package = pkgs.rofi;
  };
}
