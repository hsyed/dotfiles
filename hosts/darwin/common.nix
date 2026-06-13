{ pkgs, config, ... }:

{
  environment = {
    systemPackages = [
      pkgs.nh
    ];

    variables.NH_FLAKE = "${config.users.users.${config.system.primaryUser}.home}/.dotfiles";

    systemPath = [
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
    ];
  };

  determinateNix.enable = true;

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-mono
  ];

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    onActivation.extraFlags = [ "--force-cleanup" ];
    casks = [
      "ghostty"
      "hammerspoon"
      "logseq"
      "rectangle-pro"
      "zed"
      "karabiner-elements"
    ];
  };

  # sudo now authenticates with touch id
  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    defaults = {
      # 3 finger app drag and text highlighting
      trackpad.TrackpadThreeFingerDrag = true;
      # autohide the menu bar
      NSGlobalDomain._HIHideMenuBar = true;
      dock = {
        autohide = true;
        # avoid accidental gesture triggers and discourage reliance on these features
        showMissionControlGestureEnabled = false;
        showDesktopGestureEnabled = false;
      };
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
}
