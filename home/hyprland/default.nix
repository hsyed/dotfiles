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
    # TODO: move the next 3 components to the system level configuration
    hyprshot # Screenshot utility for Hyprland
    wl-clipboard # for cli tools to interact with the wayland clipboard
    wtype # Wayland text input tool.abort

    rofimoji # Standalone emoji picker with better XWayland support via ydotool

    # fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    noto-fonts # For Noto Serif/Sans
    noto-fonts # Additional font families
    noto-fonts-color-emoji # Color emoji support
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

  services.tailscale-systray = {
    enable = true;
  };
}
