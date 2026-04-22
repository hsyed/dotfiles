{ pkgs, config, ... }:

{
  determinateNix.enable = true;

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-mono
  ];

  environment = {
    systemPackages = [
      pkgs.vim
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

  system = {
    primaryUser = "hsyed";
    defaults = {
      # 3 finger app drag and text highlighting
      trackpad.TrackpadThreeFingerDrag = true;
      # autohide the dock
      dock.autohide = true;
    };
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; # pkgs not declared will be cleaned up
    casks = [
      "claude" # claude desktop
      "ghostty"
      "signal"
      "logseq"
    ];
    masApps = {
      "Tailscale" = 1475387142;
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.hsyed = {
    name = "Hassan Syed";
    home = "/Users/hsyed";
  };
}
