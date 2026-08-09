{ config, ... }:
let
  c = config.lib.stylix.colors.withHashtag;
  r = config.lib.stylix.colors;
in
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = [ "hyprland-session.target" ];
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-top = 3;
        margin-left = 1156;
        margin-right = 1156;

        modules-left = [
          "hyprland/workspaces"
          "tray"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "custom/notification"
          "pulseaudio"
          "memory"
          "cpu"
          "disk"
        ];

        # SwayNC notification module
        "custom/notification" = {
          tooltip = false;
          format = "{}";
          exec-if = "which swaync-client";
          exec = ''
            count=$(swaync-client -c)
            if [ "$count" -gt 0 ]; then
              echo "<span foreground='${c.base08}'>󰂚 $count</span>"
            else
              echo "<span foreground='${c.base03}'>󰂚</span>"
            fi
          '';
          interval = 1;
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
        };

        # Workspaces module adapted for Hyprland
        "hyprland/workspaces" = {
          disable-scroll = true;
          format = "{name}";
          show-special = true; # scratchpad shows up while it holds windows
        };

        clock = {
          format = "{:%a %d %b  %H:%M}";
          tooltip = false;
        };

        # System modules
        pulseaudio = {
          format = "VOL {volume:2}%";
          format-bluetooth = "BT {volume:2}%";
          format-muted = "MUT {volume:2}%";
          format-icons = {
            headphones = "󰋋";
            default = [
              ""
              ""
            ];
          };
          scroll-step = 5;
          on-click = "pamixer -t";
          on-click-right = "pavucontrol";
        };

        memory = {
          interval = 5;
          format = "RAM {}%";
        };

        cpu = {
          interval = 5;
          format = "CPU {usage:2}%";
        };

        disk = {
          interval = 5;
          format = "SSD {percentage_used:2}%";
          path = "/";
        };

        tray = {
          icon-size = 20;
          spacing = 8;
          show-passive-items = true;
        };
      };
    };

    style = ''
      * {
        font-size: 15px;
        font-family: "JetBrainsMono Nerd Font", monospace;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background: rgba(${r.base00-rgb-r}, ${r.base00-rgb-g}, ${r.base00-rgb-b}, 0.72);
        border: 1px solid rgba(${r.base05-rgb-r}, ${r.base05-rgb-g}, ${r.base05-rgb-b}, 0.18);
        border-radius: 10px;
        color: ${c.base05};
      }

      #workspaces,
      #clock,
      #custom-notification,
      #pulseaudio,
      #memory,
      #cpu,
      #disk,
      #tray {
        background: ${c.base00};
        border: 1px solid ${c.base02};
        border-radius: 999px;
        margin: 4px 3px;
      }

      #workspaces {
        padding: 0 4px;
      }

      #workspaces button {
        min-width: 22px;
        padding: 0 7px;
        margin: 3px 2px;
        color: ${c.base04};
        border-radius: 999px;
      }

      #workspaces button.focused,
      #workspaces button.active {
        color: ${c.base00};
        background: ${c.base0D};
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        color: ${c.base05};
        background: ${c.base02};
        padding: 0 7px;
      }

      #workspaces button.urgent {
        color: ${c.base00};
        background: ${c.base08};
      }

      /* scratchpad pill matches the amber scratchpad window border */
      #workspaces button.special {
        color: ${c.base0A};
      }

      #pulseaudio {
        color: ${c.base05};
        border-color: ${c.base0D};
        min-width: 58px;
      }

      #memory {
        color: ${c.base05};
        border-color: ${c.base0B};
        min-width: 58px;
      }

      #cpu {
        color: ${c.base05};
        border-color: ${c.base0E};
        min-width: 50px;
      }

      #disk {
        color: ${c.base05};
        border-color: ${c.base0A};
        min-width: 58px;
      }

      #custom-notification {
        color: ${c.base05};
        border-color: ${c.base08};
      }

      #pulseaudio.muted {
        color: ${c.base04};
        border-color: ${c.base08};
      }

      #clock,
      #custom-notification,
      #pulseaudio,
      #memory,
      #cpu,
      #disk {
        padding: 0 12px;
      }

      #tray {
        padding: 0 12px;
        margin-left: 10px;
      }
    '';
  };
}
