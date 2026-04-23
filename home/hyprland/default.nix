{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./wofi.nix
    ./rofi.nix
    ../apps/ghostty.nix
    ./idle.nix
    ./lock.nix
    ./awww.nix
    ./swaync.nix
    ./yazi.nix
    ./chromium.nix
  ];

  home.packages = with pkgs; [
    hyprshot # Screenshot utility for Hyprland
    wl-clipboard # for cli tools to interact with the wayland clipboard
    wtype # Wayland text input tool.abort
    rofimoji # Standalone emoji picker with better XWayland support via ydotool
    pavucontrol # used as general audio control
    pamixer # used for muting

    # fonts
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-mono # For Caskaydia Mono Nerd Font

    # Desktop applications
    spotify
    discord
    signal-desktop
    zoom-us
    transmission_4-gtk # torrent client
    mpv # media player
    logseq # note taker
    sox # audio tool required for claude-code voice input
    protonup-ng # manage proton runtime updates (gaming related)
    dua # disk usage analyzer

    (pkgs.jetbrains.rust-rover.override {
      #jdk = pkgs.jdk; # uncomment this if there is an issue building with the jebtrains jdk
    })

  ];

  xdg.userDirs = {
    enable = true;
    # create the standard XDG user directories if they are missing like ~/Documents, ~/Downloads, etc.
    createDirectories = true;
    setSessionVariables = true;
  };

  stylix.targets.qt.enable = true;

  gtk.gtk4.theme = config.gtk.theme;

  services = {
    hyprpolkitagent.enable = true;

    cliphist = {
      enable = true;
      allowImages = true; # rofi does not deal with images well (tiny icons).
    };

    tailscale-systray.enable = true;
  };
}
