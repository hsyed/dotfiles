{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    settings = {
      "$mod" = "SUPER";
      "$webapp" = "chromium --new-window --ozone-platform=wayland --app";

      bind = [
        "$mod, Return, exec, kitty" # Terminal
        "$mod, Q, killactive"
        "$mod SHIFT, Escape, exit" # kill hyprland
        "$mod, M, exec, spotify" # Spotify
        "$mod, D, exec, kitty btop" # System monitor
        "$mod, E, exec, dolphin" # File manager
        "$mod, B, exec, chromium --new-window --ozone-platform=wayland" # Browser
        "$mod SHIFT, V, togglefloating"
        "$mod, Space, exec, rofi -show combi -combi-modes \"window,drun,ssh\" -modes combi" # App launcher
        # TODO style rofi
        "$mod SHIFT, C, exec, rofi -modi clipboard:cliphist-rofi-img -show clipboard -show-icons"
        "$mod, Escape, exec, hyprlock --immediate" # Lock screen without grace period for credentials

        # apps
        "$mod SHIFT, A, exec, $webapp=\"https://claude.ai/new\""

        # Move focus with mod + vim keys
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # Move focus with mod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Move windows with mod + SHIFT + vim keys
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"

        # Move windows with mod + SHIFT + arrow keys
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        # Switch workspaces with mod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window to a workspace with mod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Screenshot bindings
        ", PRINT, exec, hyprshot --clipboard-only -m region"
        "SHIFT, PRINT, exec, hyprshot --clipboard-only -m window"

        # Wallpaper control
        "$mod, slash, exec, wpaperctl next"
      ];

      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # General settings
      general = {
        gaps_in = 1;
        gaps_out = 3;
        border_size = 3;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "master";
      };

      # Decoration settings
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      # Animation settings
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 3.5, myBezier"
          "windowsOut, 1, 3.5, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 3.5, default"
          "workspaces, 1, 1.5, default, fade"
        ];
      };

      # Input settings
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification
      };

      # Window rules
      windowrulev2 = [
        "opacity 0.98 0.95, class:.*"
        "opacity 1.0 1.0, class:^(chromium-browser)$"
      ];

      # Master layout configuration (see: https://wiki.hypr.land/Configuring/Master-Layout/)
      # - Master window always centered (orientation = "center")
      # - New windows become slaves to preserve master centrality
      # - pain point: closing left slave with a right slave causes it toake the position of the left.
      master = {
        new_status = "slave"; # New windows become slaves
        new_on_top = false; # New slaves added to bottom
        mfact = 0.55; # Master takes 55% of screen
        orientation = "center"; # place the master in the center
        slave_count_for_center_master = 0; # Center master all the time
      };

      # Cursor settings
      #cursor = {
      #  no_hardware_cursors = true;
      #};

      # Environment variables for cursor
      env = [
        "XCURSOR_THEME,Bibata-Modern-Amber"
        "XCURSOR_SIZE,24"
      ];

      # Misc settings
      misc = {
      };

      # Monitor configuration (adjust to your setup)
      # bitdepth,10 = 10-bit color depth (1024 shades per RGB channel)
      # cm,hdr = HDR color management with wide gamut and PQ transfer function
      # sdrbrightness,1.45 = SDR content brightness in HDR mode (1.0-2.0 range)
      # sdrsaturation,1.2 = SDR content saturation boost in HDR mode
      monitor = ",5120x1440@240,auto,1";
    };
  };
}
