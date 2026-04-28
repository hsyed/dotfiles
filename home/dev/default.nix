{ pkgs, ... }:
{
  imports = [
    ./npm.nix
    ./nvim_lazyvim.nix
  ];

  home.packages = [
    pkgs.ripgrep # rg better than grep.
    pkgs.k9s # Kubernetes CLI
    pkgs.nushell
    pkgs.rustup # Rust toolchain manager
    pkgs.go # Go programming language
    pkgs.gopls # go LSP
    pkgs.protobuf # protocol buffers
    pkgs.clang # C/C++ compiler
    pkgs.mold # fast linker
    pkgs.nodejs
    pkgs.fd
    pkgs.lsd # modern ls replacement
    pkgs.sqlite
    pkgs.deno
    pkgs.cue
    pkgs.nil # don't use lazyvim - Mason nil, it doesnt link properly on Darwin
    pkgs.uv # currently installed for mcp support for logseq
    # Markdown LSP -- this is a dotnet app -- mason maanged version has issue linking to icu 😭.
    pkgs.marksman
    pkgs.kubectl # Kubernetes CLI
    pkgs.kind # Kubernetes in Docker
    pkgs.statix # linter for nix files used nil_ls via lazvim/mason
    pkgs.kcl # config generator
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
        init = {
          defaultBranch = "main";
        };
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
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
        "nx.sys.switch" =
          if pkgs.stdenv.isDarwin then
            "nh darwin switch --ask ~/.dotfiles"
          else
            "nh os switch --ask ~/.dotfiles";
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
