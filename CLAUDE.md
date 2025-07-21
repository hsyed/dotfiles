# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a NixOS and Home Manager dotfiles repository for user `hsyed` on the `catharsis` system. It uses Nix flakes to manage both system-level and user-level configurations declaratively.

## Flake Architecture

- **Hardware notes**:
  - NVIDIA GPU with open drivers enabled.
  - Hyprland window manager with XWayland support.
  - PipeWire audio system with ALSA and PulseAudio compatibility.
- **Flake-based configuration**: `flake.nix` defines inputs (nixpkgs, home-manager) and outputs (nixosConfigurations, homeConfigurations).
- **System configuration/NixOS**: `system` - NixOS system-level settings including hardware, services, and system packages.
- **User configuration/home-manager**: Split across multiple files:
  - `home/home.nix` - Core Home Manager configuration with basic packages (chromium)
  - `home/dev.nix` - Development tools and CLI utilities (ripgrep, k9s, claude-code, git, etc.)
  - `home/hyprland/` - Hyprland window manager configuration module
- **Target system**: `catharsis` (x86_64-linux) with NVIDIA GPU support and Hyprland desktop environment
- **Primary user**: `hsyed`
- **Default shell**: zsh

## Hyperland / Graphical environement Setup

This setup uses Hyprland (Wayland compositor) as the desktop environment:

### Architecture
- **System level**: Hyprland enabled in `system/configuration.nix` with XWayland support
- **User level**: Configuration split across `home/hyprland/` module files:
  - `hyprland.nix` - Core Hyprland settings and SwayNC notifications
  - `waybar.nix` - Status bar with system metrics and custom styling
  - `wofi.nix` - Application launcher with theming
- **Applications**: Ghostty (terminal), Dolphin (file manager), Chromium (browser)
- **Audio**: PipeWire system with pamixer/pavucontrol controls

### Key Applications
- Terminal: `ghostty` (Super+Return)
- File Manager: `dolphin` (Super+E)
- Browser: `chromium` (Super+B)
- Launcher: `wofi` (Super+Space)

## Development Principles

- **Prefer Nix modules over manual package installation**: When configuring software, always check if a NixOS/Home Manager module exists first (e.g., `programs.git`, `services.docker`, `programs.neovim`). Use these modules instead of manually adding packages to `home.packages` or `environment.systemPackages`, as modules provide idiomatic configuration, proper integration, and sensible defaults.
- **Explicitly document configuration choices**: When modules offer configuration options, explicitly set values even when they match defaults for documentation purposes. This makes the configuration self-documenting and intentions clear, rather than relying off implicit defaults that may change over time.

## Security Guidelines

### Git Repository Security
- **Never commit secrets**: SSH private keys, GPG keys, API tokens, passwords, or certificates

### NixOS Configuration Security
- **Minimal privilege**: Only enable required services and packages
- **Secure defaults**: Use NixOS security modules and firewall configurations
- **Secret management**: Use 0Password CLI (`_1password`) for secure credential access in scripts and configurations

## Common Commands

### Building and Switching Configurations

```bash
# Rebuild NixOS system configuration
sudo nixos-rebuild switch --flake .#catharsis

# Apply Home Manager configuration
home-manager switch --flake .#hsyed@catharsis

# build command just does a dry-run without installing
```

### Formatting and Validation

```bash
# Format Nix files (configured formatter: nixfmt-tree)
nix fmt

# Check flake
nix flake check

# Show flake info
nix flake show
```

### Development Workflow

```bash
# Update flake inputs
nix flake update

# Update specific input
nix flake update nixpkgs

# Enter development shell with specific packages
nix shell nixpkgs#package-name
```
