# NixOS Dotfiles

Combined NixOS and Home Manager flake for user `hsyed` on host `catharsis`.

## System Configuration

- **OS**: NixOS (x86_64-linux)
- **Nixpkgs**: Tracks `nixos-unstable` channel
- **Hardware**: NVIDIA GPU with open drivers
- **Desktop**: Hyprland (Wayland compositor) with XWayland support
- **Audio**: PipeWire with ALSA/PulseAudio compatibility
- **Shell**: zsh (default)

## Structure

- `system/` - NixOS system modules
- `home/` - Home Manager user modules
- `home/dev.nix` - Development tools and CLI utilities
- `home/nvim/` - Neovim configuration (LazyVim-based)
- `home/hyprland/` - Hyprland window manager setup

This repository is designed to be modified with Claude Code agent assistance.

## Notes

### Emojis and Emoji pickers

Emojis once selected need to be injected into apps via either Wayland or X11/XWayland. Pickers can inject a char directly or go via the clipboard.

Rofimoji has the broadest support and to get it injecting in all places both ydotool (for char injection) and the clipboard mode via wl-clipboard/wl-copy is needed.

### Out for store / dynamic linking

**Dynamic Linking Support**: `nix-ld` is enabled to support development tools that require dynamic linking outside the Nix store. This enables:

- **RustRover** - JetBrains Rust IDE (precompiled binary)
- **Neovim** - System-level installation with custom Lua configuration
- **VSCode / Zed** - Modern editors requiring system library access
- Other language servers and development utilities
