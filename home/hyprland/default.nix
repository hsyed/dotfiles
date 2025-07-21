{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./wofi.nix
    ./kitty.nix
    ./idle.nix
    ./lock.nix
    ./wpaperd.nix
    ./swaync.nix
  ];

  home.packages = with pkgs; [
    hyprshot # Screenshot utility for Hyprland
    kdePackages.dolphin

    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    noto-fonts # For Noto Serif/Sans
    nerd-fonts.caskaydia-mono # For Caskaydia Mono Nerd Font
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

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "Caskaydia Mono Nerd Font" ];
      };
    };
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

  # Polkit authentication agent
  services.hyprpolkitagent.enable = true;
}
