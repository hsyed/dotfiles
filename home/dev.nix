{ pkgs, config, ... }:
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
    pkgs.protobuf # protocol buffers
    pkgs.clang # C/C++ compiler
    pkgs.mold # fast linker
    pkgs.nixd # nix lsp
    pkgs.nodejs
    pkgs.fd
    pkgs.lsd # modern ls replacement
    pkgs.sqlite
    pkgs.deno
    pkgs.cue
    pkgs.nil # Abother Nix LSP (?)
    # Markdown LSP -- this is a dotnet app -- mason maanged version has issue linking to icu 😭.
    pkgs.marksman
    pkgs.docker-compose # docker-compose for podman
    pkgs.podman-desktop # docker desktop for podman
    pkgs.kubectl # Kubernetes CLI
    pkgs.kind # Kubernetes in Docker
    (pkgs.jetbrains.rust-rover.override {
      #jdk = pkgs.jdk; # uncomment this if there is an issue building with the jebtrains jdk
    })
  ];

  # This creates a symlink which ultimately resolves to the ~/.dotfile directory.
  # The config can't be immutable as lazy uses a lock file. A better approach for
  # lazyvim config might just be to have a manual script to setup symlinks for cases
  # like lazyvim. Or moving vim config to the flake.
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/nvim";
  };

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
      settings = {
        user = {
          name = "Hassan Syed";
          email = "h.a.syed@gmail.com";
        };
        alias = {
          st = "status";
        };
        core = {
          editor = "nvim"; # lazygit picks this up
        };
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
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
        cd = "z"; # use zoxide for cd
        ls = "lsd";
        ll = "lsd -l";
        la = "lsd -la";
        tree = "lsd --tree";
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

    zellij = {
      enable = true;
      settings = {
        simplified_ui = true;
        pane_frames = false;
        theme = "gruvbox-dark";

        keybinds = {
          normal = {
            unbind = [
              "Ctrl h" # ctrl+h is used by lazyvim.
            ];
            "bind \"Ctrl m\"" = {
              SwitchToMode = "move";
            };
          };
        };
      };
    };
  };
}
