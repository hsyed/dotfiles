{ ... }:

{
  imports = [
    ../common.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew = {
    brews = [
      "argocd"
      "helm"
    ];
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
