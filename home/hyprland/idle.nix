{  ... }:
{
  # Hypridle idle management daemon
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300; # 5 minutes
          on-timeout = "hyprlock";
        }
        {
          timeout = 600; # 10 minutes
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        # uncomment for suspend
        # {
        #   timeout = 1800; # 30 minutes
        #   on-timeout = "systemctl suspend";
        # }
      ];
    };
  };
}
