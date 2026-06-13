{ pkgs, ... }:

{
  imports = [
    ../common.nix
  ];

  environment.systemPackages = [
    pkgs._1password-gui
  ];

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
