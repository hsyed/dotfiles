{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./wofi.nix
    ./rofi.nix
    ./ghostty.nix
    ./idle.nix
    ./lock.nix
    ./wpaperd.nix
    ./swaync.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    hyprshot # Screenshot utility for Hyprland
    wl-clipboard # for cli tools to interact with the wayland clipboard

    # fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    noto-fonts # For Noto Serif/Sans
    noto-fonts-extra # Additional font families
    noto-fonts-emoji # Color emoji support
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
    extensions = [
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock origin lite
    ];
  };


  xdg.userDirs = {
    enable = true;
    # create the standard XDG user directories if they are missing like ~/Documents, ~/Downloads, etc.
    createDirectories = true;
  };

  # Polkit authentication agent
  services.hyprpolkitagent.enable = true;

  services.cliphist = {
    enable = true;
    allowImages = true; # rofi does not deal with images well (tiny icons).
  };
}
