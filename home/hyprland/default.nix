{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./wofi.nix
    ./kitty.nix
  ];

  home.packages = [
    pkgs.kdePackages.dolphin
    # Nerd Fonts for waybar and terminal icons
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
  ];
}
