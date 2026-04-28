# NixOS Dotfiles

Combined NixOS, Darwin and Home Manager flake for various hosts.

## Workstation-first development environment

This flake is for day-to-day workstation and development use, so it is not
strictly "pure Nix" everywhere. Some tools are intentionally allowed to manage
their own fast-moving state when that makes the machine more useful.

Non-Nix-managed patterns used on purpose:

- `nix-ld` is enabled on Linux (`system/catharsis/configuration.nix`) to support
  developer tooling that expects dynamic linking outside the Nix store. The same
  pattern may be enabled on Darwin if it proves useful there.
- `npm` uses the Nix-provided Node.js runtime, but global npm packages are
  installed under `~/.npm` (`home/dev/npm.nix`). This keeps CLIs such as Claude,
  Codex, and similar tools easy to update without waiting for nixpkgs.
- Neovim is a LazyVim setup in `home/nvim`, linked into `~/.config/nvim` via an
  out-of-store Home Manager symlink (`home/dev/nvim_lazyvim.nix`). LazyVim,
  `lazy-lock.json`, and Mason-managed tools can then evolve like a normal editor
  config, including tooling that may live outside the Nix store.
