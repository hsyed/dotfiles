{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;

    enableZshIntegration = true;

    # dunno what this does yet
    # installVimSyntax = false;

    settings = {
      theme = "GruvboxDark";
    };
  };
}
