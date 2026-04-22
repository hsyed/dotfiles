{ pkgs, config, ... }:

{
  determinateNix.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    pkgs.vim
    pkgs.nh
    pkgs._1password-gui
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-mono
  ];

  environment.variables.NH_FLAKE = "${config.users.users.hsyed.home}/.dotfiles";

  environment.systemPath = [ "/opt/homebrew/bin" "/opt/homebrew/sbin" ];

  system.primaryUser = "hsyed";

  security.pam.services.sudo_local.touchIdAuth = true;
  
  # 3 finger app drag and text highlighting
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; # pkgs not declared will be cleaned up
    casks = [ "ghostty" "signal" "logseq"];
    masApps = {
      "Tailscale" = 1475387142;
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.hsyed = {
    name = "Hassan Syed";
    home = "/Users/hsyed";
  };
}
