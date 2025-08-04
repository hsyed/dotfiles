{ ... }:
{
  programs.kitty = {
    enable = true;
    themeFile = "gruvbox-dark-hard";
    settings = {
      confirm_os_window_close = 0; # Disable confirmation dialogs

      # Terminal behavior
      # shell_integration = "enabled"; # TODO this breaks base nix shell settings,
      scrollback_lines = 10000;

      # Font configuration
      font_family = "JetBrains Mono Nerd Font";
      bold_font = "JetBrains Mono Nerd Font Bold";
      italic_font = "JetBrains Mono Nerd Font Italic";
      bold_italic_font = "JetBrains Mono Nerd Font Bold Italic";
      font_size = "12.0";

      # Font rendering improvements
      disable_ligatures = "never";
      font_features = "JetBrainsMono-Regular +cv02 +cv03 +cv04 +cv14 +ss04";
      adjust_line_height = "0";
      adjust_column_width = "0";
      text_composition_strategy = "platform";

      # Symbol/icon font fallbacks for better Nerd Font support
      symbol_map = "U+E0A0-U+E0A3,U+E0C0-U+E0C7 JetBrains Mono Nerd Font";

      # Window settings
      window_padding_width = 10;
      hide_window_decorations = "titlebar-only";

      # Tab bar disabled (using Hyprland for window management)
      tab_bar_style = "hidden";

      # Cursor and selection styling
      cursor = "#fbf1c7";
      cursor_text_color = "#282828";
      cursor_shape = "block";
      cursor_blink_interval = "0.5";
      cursor_stop_blinking_after = "15.0";

      # Selection colors matching gruvbox
      selection_foreground = "#282828";
      selection_background = "#fabd2f";

      # URL styling
      url_color = "#8ec07c";
      url_style = "curly";

      # Mouse and clipboard enhancements
      copy_on_select = true;
      strip_trailing_spaces = "smart";
      rectangle_select_modifiers = "ctrl+alt";

      # Click behaviors
      open_url_with = "default";
      detect_urls = true;

      # Mouse wheel scrolling
      wheel_scroll_multiplier = "5.0";

      # Performance
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;
    };

    keybindings = {
      # Clipboard
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";

      # Font size
      "ctrl+shift+equal" = "increase_font_size";
      "ctrl+shift+minus" = "decrease_font_size";
      "ctrl+0" = "restore_font_size";

      # Scrollback navigation
      "ctrl+shift+k" = "scroll_line_up";
      "ctrl+shift+j" = "scroll_line_down";
      "ctrl+shift+page_up" = "scroll_page_up";
      "ctrl+shift+page_down" = "scroll_page_down";
      "ctrl+shift+home" = "scroll_home";
      "ctrl+shift+end" = "scroll_end";

      # Search in scrollback
      "ctrl+shift+f" = "show_scrollback";
      "ctrl+shift+h" = "show_last_command_output";

      # Useful kittens
      "ctrl+shift+u" = "kitten unicode_input";
    };
  };
}
