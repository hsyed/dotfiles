{ config, ... }:
# wpaperd manages wallpapers, we use it over the others as it allows for rotating wallpapers in a directory without any additional configuration.
# A hotkey should be assigned to `wpaperctl next` which cycles through wallpapers stored in ~/Pictures/wallpapers.
#
# Notes: Consider adding some default wallpapers -- though I don't want to clutter the repo with high res images and don't fancy twiddling with git submodules or external storage etc atm.
{
  # Ensure wallpapers directory exists
  # TODO : find some better way.
  home.activation.createWallpaperDir = ''
    mkdir -p "${config.home.homeDirectory}/Pictures/wallpapers"
  '';

  services.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = "${config.home.homeDirectory}/Pictures/wallpapers";
        duration = "30m";
        sorting = "random";
      };
    };
  };

  # wpaperd crashes for some reason when resuming the machine from a display shut off.
  systemd.user.services.wpaperd = {
    Unit.After = [ "graphical-session.target" ];
    Service = {
      Restart = "on-failure";
      RestartSec = "1";
    };
  };
}
