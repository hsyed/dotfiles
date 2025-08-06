# common stylix theme configuration, only add theme elements to this file and leave
# toggling targets to nixos/hm.
{ pkgs, ... }:
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
    };

    # Cursor theme
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Amber";
      size = 24;
    };
  };
}
