{ pkgs, ... }:
{
  home.packages = [
    pkgs.logseq
  ];

  # pkgs.logseq currently depends on electron-39.8.10, which nixpkgs marks
  # insecure because Electron 39 is EOL. Keep the exception next to Logseq so
  # it is obvious what requires it. Flatpak may be a better alternative if this
  # exception lingers.
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];
}
