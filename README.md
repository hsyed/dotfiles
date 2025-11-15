# NixOS Dotfiles

Combined NixOS and Home Manager flake for user `hsyed` on host `catharsis`.

## System Configuration

- **OS**: NixOS (x86_64-linux)
- **Nixpkgs**: Tracks `nixos-unstable` channel
- **Hardware**: NVIDIA GPU with open drivers
- **Desktop**: Hyprland (Wayland compositor) with XWayland support
- **Audio**: PipeWire with ALSA/PulseAudio compatibility
- **Shell**: zsh (default)

## Development Setup

**Dynamic Linking Support**: `nix-ld` is enabled to support development tools that require dynamic linking outside the Nix store. This enables:

- **RustRover** - JetBrains Rust IDE (precompiled binary)
- **Neovim** - System-level installation with custom Lua configuration
- **VSCode / Zed** - Modern editors requiring system library access
- Other language servers and development utilities

## Structure

- `system/` - NixOS system modules
- `home/` - Home Manager user modules
- `home/dev.nix` - Development tools and CLI utilities
- `home/nvim/` - Neovim configuration (LazyVim-based)
- `home/hyprland/` - Hyprland window manager setup

This repository is designed to be modified with Claude Code agent assistance.

