# common stylix theme configuration, only add theme elements to this file and leave
# toggling targets to nixos/hm.
# https://nix-community.github.io/stylix/
{ lib, pkgs, ... }:
{
  stylix = {

    # Use a base16 theme - you can change this to any base16 theme
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    # Force dark mode
    polarity = "dark";

    # Set fonts to match your previous configuration
    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    # Cursor theme. Linux only: stylix wires this into `home.pointerCursor`,
    # which home-manager asserts is Linux-only, but its gtk/x11/sway targets
    # still flip `home.pointerCursor.<backend>.enable` on any platform whenever
    # `stylix.cursor` is non-null. On Darwin that leaves `home.pointerCursor`
    # enabled with no `name`/`package`, breaking evaluation.
    cursor = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Amber";
      size = 24;
    };
  };
}
