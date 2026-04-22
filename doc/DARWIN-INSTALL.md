# etup "hsyed@personal" on Darwin

First install [Determinate nix](https://docs.determinate.systems/determinate-nix/#getting-started).

Then checkout `github.com/hsyed/dotfiles to ~/.dotfiles/`

Install Homebrew `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

Bootstrap nix-darwin with `sudo run nix-darwin -- switch --flake ~/.dotfiles#personal`

Bootstrap home-manager with `nix run home-manager -- switch --flake ~/.dotfiles#hsyed@personal`
