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
    pkgs.gopls # go LSP
    pkgs.clang # C/C++ compiler
    pkgs.mold # fast linker
    pkgs.nixd # nix lsp
    pkgs.nodejs
    pkgs.fd
    pkgs.sqlite
    pkgs.deno
    pkgs.cue
    pkgs.torrential
    pkgs.mpv # media player
    pkgs.docker-compose # docker-compose for podman
    pkgs.podman-desktop # docker desktop for podman
    pkgs.kubectl # Kubernetes CLI
    pkgs.kind # Kubernetes in Docker
    (pkgs.jetbrains.rust-rover.override {
      #jdk = pkgs.jdk; # uncomment this if there is an issue building with the jebtrains jdk
    })
  ];

  programs = {
    jq.enable = true;
    btop.enable = true;
    bat.enable = true;
    gh.enable = true;
    lazygit.enable = true;

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      # zoxide is a smarter cd command - tracks history.
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      userName = "Hassan Syed";
      userEmail = "h.a.syed@gmail.com";
      aliases = {
        st = "status";
      };
      extraConfig = {
        core.editor = "nvim"; # lazygit picks this up
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
        "nx.sys.switch" = "nh os switch --ask ~/.dotfiles";
        "nx.home.switch" = "nh home switch --ask ~/.dotfiles";
        "nx.clean" = "nh clean all --ask --keep 10";
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
