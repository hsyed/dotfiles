{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    # this package comes from a cask on Darwin
    package = if pkgs.stdenv.isDarwin then null else pkgs.ghostty;

    # Ghostty's zsh shell integration injects OSC 133 prompt markers. Those can
    # interact badly with prompt-modifying shells like `kubie ctx`, making the
    # command line hard to edit. Upstream context:
    # https://github.com/ghostty-org/ghostty/discussions/12502
    # https://github.com/ghostty-org/ghostty/discussions/10555
    enableZshIntegration = false;

    settings = {
      shell-integration = "none";
      theme = "Gruvbox Dark";
    };
  };

  stylix.targets.ghostty.enable = false;
}
