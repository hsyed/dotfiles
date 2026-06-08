{ ... }:

{
  # sudo now authenticates with touch id
  security.pam.services.sudo_local.touchIdAuth = true;

  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; # pkgs not declared will be cleaned up
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

  system.primaryUser = "hassan.syed";
}
