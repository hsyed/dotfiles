{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    # this package comes from a cask on Darwin
    package = if pkgs.stdenv.isDarwin then null else pkgs.ghostty;

    enableZshIntegration = true;

    settings = {
      theme = "Gruvbox Dark";
    };
  };
}
