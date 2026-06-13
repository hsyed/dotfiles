{ ... }:

{
  imports = [
    ../common.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew = {
    casks = [
      "gcloud-cli"
    ];
  };

  system.primaryUser = "hassan.syed";

  users.users."hassan.syed" = {
    name = "Hassan Syed";
    home = "/Users/hassan.syed";
  };
}
