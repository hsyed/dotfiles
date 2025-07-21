{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0; # Disable confirmation dialogs

      # Terminal behavior
      # shell_integration = "enabled"; # TODO this breaks base nix shell settings,
      scrollback_lines = 10000;

      # Font configuration
      font_family = "JetBrains Mono";
      font_size = "12.0";

      # Theme and appearance
      background_opacity = "0.85";
      dynamic_background_opacity = true;

      # Window settings
      window_padding_width = 10;
      hide_window_decorations = "titlebar-only";

      # Tab configuration
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";

      # Performance
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;
    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+equal" = "increase_font_size";
      "ctrl+shift+minus" = "decrease_font_size";
    };
  };
}
