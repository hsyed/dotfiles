# Home Manager Configuration Options Reference

This document provides structured knowledge of Home Manager configuration options for declarative user environment management.

## Core Configuration Structure

### Top-Level Options
- `home.username`: String - Username for the home directory
- `home.homeDirectory`: String - Path to home directory
- `home.stateVersion`: String - Home Manager release version
- `home.packages`: List - Packages to install in user environment
- `home.file`: Attribute set - Files to manage in home directory
- `home.sessionVariables`: Attribute set - Environment variables
- `home.sessionPath`: List - Additional PATH entries
- `home.shellAliases`: Attribute set - Shell aliases

## Programs Configuration (`programs.*`)

### Development Tools
- `programs.git.*`:
  - `enable`: Boolean - Enable Git
  - `userName`: String - User name for commits
  - `userEmail`: String - User email for commits
  - `extraConfig`: Attribute set - Additional git configuration
  - `aliases`: Attribute set - Git command aliases
  - `signing`: Attribute set - GPG signing configuration

- `programs.neovim.*`:
  - `enable`: Boolean - Enable Neovim
  - `defaultEditor`: Boolean - Set as default editor
  - `plugins`: List - Neovim plugins
  - `extraConfig`: String - Additional configuration
  - `extraLuaConfig`: String - Lua configuration

- `programs.vscode.*`:
  - `enable`: Boolean - Enable VS Code
  - `extensions`: List - Extensions to install
  - `userSettings`: Attribute set - User settings
  - `keybindings`: List - Custom keybindings

### Shell Configuration
- `programs.bash.*`:
  - `enable`: Boolean - Enable Bash configuration
  - `bashrcExtra`: String - Additional bashrc content
  - `profileExtra`: String - Additional profile content
  - `shellAliases`: Attribute set - Bash aliases
  - `historyControl`: List - History control options

- `programs.zsh.*`:
  - `enable`: Boolean - Enable Zsh configuration
  - `enableCompletion`: Boolean - Enable completion system
  - `enableAutosuggestions`: Boolean - Enable autosuggestions
  - `enableSyntaxHighlighting`: Boolean - Enable syntax highlighting
  - `oh-my-zsh`: Attribute set - Oh My Zsh configuration
  - `plugins`: List - Zsh plugins
  - `initExtra`: String - Additional zsh configuration

- `programs.fish.*`:
  - `enable`: Boolean - Enable Fish shell
  - `plugins`: List - Fish plugins
  - `shellAliases`: Attribute set - Fish aliases
  - `functions`: Attribute set - Custom functions

### Terminal & Multiplexers
- `programs.tmux.*`:
  - `enable`: Boolean - Enable tmux
  - `keyMode`: String - Key mode (vi/emacs)
  - `prefix`: String - Prefix key
  - `plugins`: List - Tmux plugins
  - `extraConfig`: String - Additional tmux configuration

- `programs.alacritty.*`:
  - `enable`: Boolean - Enable Alacritty terminal
  - `settings`: Attribute set - Alacritty configuration

- `programs.kitty.*`:
  - `enable`: Boolean - Enable Kitty terminal
  - `settings`: Attribute set - Kitty configuration
  - `font`: Attribute set - Font configuration

### System Utilities
- `programs.direnv.*`:
  - `enable`: Boolean - Enable direnv
  - `enableBashIntegration`: Boolean - Enable bash integration
  - `enableZshIntegration`: Boolean - Enable zsh integration
  - `nix-direnv.enable`: Boolean - Enable nix-direnv

- `programs.fzf.*`:
  - `enable`: Boolean - Enable fzf fuzzy finder
  - `enableBashIntegration`: Boolean - Enable bash integration
  - `enableZshIntegration`: Boolean - Enable zsh integration
  - `defaultCommand`: String - Default search command
  - `defaultOptions`: List - Default fzf options

### Browser & Web
- `programs.firefox.*`:
  - `enable`: Boolean - Enable Firefox
  - `profiles`: Attribute set - Firefox profiles configuration
  - `extensions`: List - Extensions to install

- `programs.chromium.*`:
  - `enable`: Boolean - Enable Chromium
  - `extensions`: List - Extensions to install
  - `commandLineArgs`: List - Command line arguments

## Services Configuration (`services.*`)

### System Services
- `services.gpg-agent.*`:
  - `enable`: Boolean - Enable GPG agent
  - `enableSshSupport`: Boolean - Enable SSH support
  - `pinentryFlavor`: String - Pinentry program

- `services.syncthing.*`:
  - `enable`: Boolean - Enable Syncthing
  - `tray`: Boolean - Enable system tray

### Desktop Services
- `services.dunst.*`:
  - `enable`: Boolean - Enable Dunst notification daemon
  - `settings`: Attribute set - Dunst configuration

- `services.redshift.*`:
  - `enable`: Boolean - Enable Redshift
  - `latitude`: String - Geographic latitude
  - `longitude`: String - Geographic longitude
  - `temperature`: Attribute set - Day/night temperatures

## Accounts Configuration (`accounts.*`)

### Email Accounts
- `accounts.email.accounts.<name>.*`:
  - `address`: String - Email address
  - `realName`: String - Real name for emails
  - `primary`: Boolean - Primary account flag
  - `imap`: Attribute set - IMAP configuration
  - `smtp`: Attribute set - SMTP configuration

### Calendar Accounts
- `accounts.calendar.accounts.<name>.*`:
  - `local`: Attribute set - Local calendar storage
  - `remote`: Attribute set - Remote calendar configuration
  - `vdirsyncer`: Attribute set - Sync configuration

### Contact Accounts
- `accounts.contact.accounts.<name>.*`:
  - `local`: Attribute set - Local contact storage
  - `remote`: Attribute set - Remote contact configuration
  - `vdirsyncer`: Attribute set - Sync configuration

## Graphical Environment

### GTK Configuration
- `gtk.*`:
  - `enable`: Boolean - Enable GTK configuration
  - `theme`: Attribute set - GTK theme settings
  - `iconTheme`: Attribute set - Icon theme settings
  - `font`: Attribute set - Default font settings
  - `gtk2.extraConfig`: String - GTK2 configuration
  - `gtk3.extraConfig`: Attribute set - GTK3 configuration

### Qt Configuration
- `qt.*`:
  - `enable`: Boolean - Enable Qt configuration
  - `platformTheme`: String - Qt platform theme
  - `style`: Attribute set - Qt style configuration

### Fonts
- `fonts.*`:
  - `fontconfig.enable`: Boolean - Enable fontconfig
  - `fontconfig.defaultFonts`: Attribute set - Default fonts

### Wayland Configuration
- `wayland.windowManager.hyprland.*`:
  - `enable`: Boolean - Enable Hyprland
  - `settings`: Attribute set - Hyprland configuration
  - `extraConfig`: String - Additional configuration

- `wayland.windowManager.sway.*`:
  - `enable`: Boolean - Enable Sway
  - `config`: Attribute set - Sway configuration
  - `extraConfig`: String - Additional configuration

### X11 Configuration
- `xsession.*`:
  - `enable`: Boolean - Enable X session management
  - `windowManager`: Attribute set - Window manager configuration
  - `initExtra`: String - Additional X session initialization

## System Integration

### XDG Configuration
- `xdg.*`:
  - `enable`: Boolean - Enable XDG configuration
  - `userDirs`: Attribute set - XDG user directories
  - `mimeApps`: Attribute set - MIME type associations
  - `desktopEntries`: Attribute set - Desktop entries

### Systemd User Services
- `systemd.user.*`:
  - `services`: Attribute set - User systemd services
  - `timers`: Attribute set - User systemd timers
  - `targets`: Attribute set - User systemd targets

## File Management

### Home Files
- `home.file.<name>.*`:
  - `source`: Path - Source file/directory
  - `text`: String - File content as string
  - `target`: String - Target location relative to home
  - `recursive`: Boolean - Copy directories recursively

### XDG Config Files
- `xdg.configFile.<name>.*`:
  - `source`: Path - Source configuration file
  - `text`: String - Configuration content
  - `target`: String - Target in .config directory

## Configuration Patterns

### Common Option Types
- `Boolean`: true/false values
- `String`: Text values
- `List`: Arrays of values
- `Attribute set`: Key-value mappings
- `Path`: File system paths
- `Package`: Nix package references

### Module Integration
- Most programs have `enable` boolean option
- Integration options (e.g., `enableBashIntegration`, `enableZshIntegration`)
- Extension/plugin systems for customization
- Configuration through `settings`, `extraConfig`, or specific options

### Best Practices
1. Use program modules instead of manual package installation
2. Enable shell integrations for tools like fzf, direnv
3. Configure through module options rather than raw config files
4. Set explicit values rather than relying on defaults for documentation
5. Use `home.file` for files that don't have dedicated modules

## Version Compatibility

Home Manager options may vary between releases. Check the official documentation for your specific Home Manager version at:
https://nix-community.github.io/home-manager/options.xhtml