{ pkgs, config, ... }:

{
  environment = {
    systemPackages = [
      pkgs.nh
      pkgs._1password-gui
    ];

    variables.NH_FLAKE = "${config.users.users.hsyed.home}/.dotfiles";

    systemPath = [
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
    ];
  };

  # sudo now authenticates with touch id
  security.pam.services.sudo_local.touchIdAuth = true;

  system.primaryUser = "hsyed";

  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; # pkgs not declared will be cleaned up
    onActivation.extraFlags = [ "--force-cleanup" ];
    casks = [
      "claude" # claude desktop
      "ghostty"
      "hammerspoon"
      "signal"
      "logseq"
      "orbstack"
      "rectangle-pro"
      "zed"
      "spotify"
      "tailscale-app"
      "zoom"
      "karabiner-elements"
    ];
  };

  users.users.hsyed = {
    name = "Hassan Syed";
    home = "/Users/hsyed";
  };

  networking = {
    hostName = "personal";
    computerName = "Hassans Macbook";
  };
}
