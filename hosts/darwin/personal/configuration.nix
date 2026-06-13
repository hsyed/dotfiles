{ pkgs, ... }:

{
  imports = [
    ../common.nix
  ];

  environment.systemPackages = [
    pkgs._1password-gui
  ];

  system.primaryUser = "hsyed";

  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew = {
    onActivation.cleanup = "zap"; # pkgs not declared will be cleaned up
    casks = [
      "claude" # claude desktop
      "signal"
      "orbstack"
      "spotify"
      "tailscale-app"
      "zoom"
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
