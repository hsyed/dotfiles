{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.ripgrep # rg better than grep.
    pkgs.k9s
    pkgs.claude-code
    pkgs.gh
    pkgs.lazygit
  ];

  programs = {
    jq.enable = true;
    btop.enable = true;
    fzf.enable = true;
    bat.enable = true;
    gh.enable = true;

    git = {
      enable = true;
      userName = "Hassan Syed";
      userEmail = "h.a.syed@gmail.com";
      aliases = {
        st = "status";
      };
    };

    zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "rust"
        "java"
        "python"
        "go"
        "typescript"
        "html"
      ];
    };
  };
}
