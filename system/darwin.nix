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
      # autohide the menu bar
      NSGlobalDomain._HIHideMenuBar = true;
      universalaccess = {
        # Replace large motion effects, such as Spaces switching, with simpler transitions.
        # macOS protects this domain; the terminal running darwin-rebuild needs Full Disk Access.
        reduceMotion = true;
        # Make translucent UI surfaces such as the menu bar, sidebars, and controls more opaque.
        reduceTransparency = true;
      };
    };
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;
  };

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
    ];
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
