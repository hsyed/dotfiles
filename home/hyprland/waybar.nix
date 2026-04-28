_: {
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
          "battery"
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
              echo "<span foreground='#dc322f'>󰂚 $count</span>"
            else
              echo "<span foreground='#666666'>󰂚</span>"
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
              ""
              ""
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

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁾"
            "󰂁"
            "󰁹"
          ];
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
        background: rgba(41, 43, 46, 0.72);
        border: 1px solid rgba(253, 246, 227, 0.18);
        border-radius: 10px;
        color: #fdf6e3;
      }

      #workspaces,
      #clock,
      #custom-notification,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk,
      #tray {
        background: #1a1a1a;
        border: 1px solid #33363b;
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
        color: #9d968a;
        border-radius: 999px;
      }

      #workspaces button.focused,
      #workspaces button.active {
        color: #fdf6e3;
        background: #2f5f7d;
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        color: #fdf6e3;
        background: #33363b;
        padding: 0 7px;
      }

      #workspaces button.urgent {
        color: #fdf6e3;
        background: #8a3a3a;
      }

      #pulseaudio {
        color: #e8e2d2;
        border-color: #3f6f90;
        min-width: 58px;
      }

      #memory {
        color: #e8e2d2;
        border-color: #4d746b;
        min-width: 58px;
      }

      #cpu {
        color: #e8e2d2;
        border-color: #67648e;
        min-width: 50px;
      }

      #battery {
        color: #e8e2d2;
        border-color: #6f7f3a;
      }

      #disk {
        color: #e8e2d2;
        border-color: #8a6f32;
        min-width: 58px;
      }

      #custom-notification {
        color: #e8e2d2;
        border-color: #8a3a3a;
      }

      #pulseaudio.muted {
        color: #a8a29a;
        border-color: #7a3f45;
      }

      #clock,
      #custom-notification,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
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
