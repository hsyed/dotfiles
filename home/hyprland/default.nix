{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./wofi.nix
    ./kitty.nix
    ./idle.nix
    ./lock.nix
  ];

  home.packages = [
    pkgs.hyprshot # Screenshot utility for Hyprland
    pkgs.kdePackages.dolphin
    pkgs.jetbrains-mono # Regular JetBrains Mono font
    # Nerd Fonts for waybar and terminal icons
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
  ];
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform,WaylandWindowDecorations"
      "--ozone-platform=wayland"
      "--gtk-version=4"
      "--enable-wayland-ime"
    ];
  };

  # GTK theming for consistent dark theme
  gtk = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      size = 11;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # Qt theming to match GTK
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
  };

  # Font configuration
  fonts.fontconfig.enable = true;
}
