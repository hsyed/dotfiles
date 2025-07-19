{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./wofi.nix
  ];

  home.packages = [
    pkgs.ghostty
    pkgs.kdePackages.dolphin
    pkgs.pavucontrol # used as general audio control
    pkgs.pamixer # used for muting
    # Nerd Fonts for waybar and terminal icons
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
  ];
}
