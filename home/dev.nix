{ pkgs, ... }:

{
  home.packages = [
    pkgs.ripgrep # rg better than grep.
    pkgs.k9s # Kubernetes CLI
    pkgs.claude-code # AI powered code editor
    pkgs.gh # GitHub CLI
    pkgs.rustc # Rust compiler
    pkgs.rustup # Rust toolchain manager
    pkgs.go # Go programming language
    pkgs.clang # C/C++ compiler
    pkgs.mold # fast linker
    pkgs.nixd # nix lsp
    (pkgs.jetbrains.rust-rover.override {
      #jdk = pkgs.jdk; # uncomment this if there is an issue building with the jebtrains jdk
    })
  ];

  programs = {
    jq.enable = true;
    btop.enable = true;
    fzf.enable = true;
    bat.enable = true;
    gh.enable = true;
    lazygit.enable = true;

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

    zsh = {
      enable = true;
      enableCompletion = true;
      autocd = true;

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history = {
        size = 10000;
        save = 10000;
        share = true;
        ignoreDups = true;
        ignoreSpace = true;
        expireDuplicatesFirst = true;
      };

      shellAliases = {
        "nx.fmt" = "env -C ~/.dotfiles nix fmt";
        "nx.verify" = "nix flake check ~/.dotfiles";
        "nx.sys.switch" = "sudo nixos-rebuild switch --flake ~/.dotfiles";
        "nx.home.switch" = "home-manager switch";
      };

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "npm"
          "history"
          "node"
          "rust"
          "deno"
          "sudo"
          "command-not-found"
        ];
      };
    };

    vscode.enable = true;
  };
}
