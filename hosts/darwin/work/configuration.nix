{ ... }:

{
  imports = [
    ../common.nix
  ];

  # sudo now authenticates with touch id
  security.pam.services.sudo_local.touchIdAuth = true;

  nixpkgs.hostPlatform = "aarch64-darwin";

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
      "gcloud-cli"
    ];
  };

  system.primaryUser = "hassan.syed";

  users.users."hassan.syed" = {
    name = "Hassan Syed";
    home = "/Users/hassan.syed";
  };
}
