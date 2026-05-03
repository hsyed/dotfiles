{ pkgs, ... }:
{
  # direnv 2.37.1 checkPhase hangs on macOS (0% CPU) due to zsh sigsuspend regression in nixpkgs darwin stdenv
  # (nixpkgs #513019, fixed in PR #513971 — remove overlay once that propagates to nixos-unstable)
  nixpkgs.overlays = [
    (_: prev: {
      direnv = prev.direnv.overrideAttrs (_: {
        doCheck = false;
      });
    })
  ];

  imports = [
    ./npm.nix
    ./nvim_lazyvim.nix
  ];

  home.packages = [
    pkgs.ripgrep # rg better than grep.
    pkgs.k9s # Kubernetes CLI
    pkgs.nushell # A modern shell for building pipelines
    pkgs.rustup # Rust toolchain manager
    pkgs.go # Go programming language
    pkgs.gopls # go LSP
    pkgs.protobuf # protocol buffers
    pkgs.clang # C/C++ compiler
    pkgs.mold # fast linker
    pkgs.nodejs # JavaScript runtime
    pkgs.fd # fast find alternative
    pkgs.lsd # modern ls replacement
    pkgs.sqlite # embedded SQL database
    pkgs.cue # data constraint language
    pkgs.nixd # LSP for nix, more advanced than nil
    pkgs.nixfmt # Nix formatter used by nixd and nix fmt
    pkgs.nix-tree # Inspect why Nix store closures are large and what depends on what
    pkgs.ruff # Python linter/formatter, replaces flake8/isort/pyupgrade-style tooling
    pkgs.uv # Python package manager, currently installed for mcp support for logseq
    # Markdown LSP -- this is a dotnet app -- mason maanged version has issue linking to icu 😭.
    pkgs.marksman
    pkgs.kubectl # Kubernetes CLI
    pkgs.kubernetes-helm # Helm CLI
    pkgs.kind # Kubernetes in Docker
    pkgs.statix # linter for nix files used nil_ls via lazvim/mason
    pkgs.kcl # config generator
    pkgs.ko # build go images direct to distroless
    pkgs.tilt # local Kubernetes development tool
  ];

  programs = {
    jq.enable = true; # jq is like sed for JSON data
    btop.enable = true; # Process/system monitoring tool (htop replacement)
    bat.enable = true; # cat with syntax highlighting and git integration
    gh.enable = true; # GitHub CLI
    lazygit.enable = true; # terminal UI for git

    fzf = {
      # fuzzy finder, press ctrl+r for fuzzy search of shell history
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
        "nx.verify" = "nix flake check --all-systems ~/.dotfiles";
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
