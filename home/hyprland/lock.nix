{ config, ... }:
{
  # Hyprlock screen locker configuration
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        grace = 10;
        hide_cursor = true;
        no_fade_in = false;
      };

      label = [
        {
          monitor = "";
          text = "$TIME";
          color = "rgb(${config.lib.stylix.colors.base05})";
          font_size = 64;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 200";
          halign = "center";
          valign = "center";
          shadow_passes = 2;
          shadow_size = 3;
        }

        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
          color = "rgb(${config.lib.stylix.colors.base04})";
          font_size = 20;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 120";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
