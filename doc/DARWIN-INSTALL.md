# Setup "hsyed@personal" on Darwin

1. Install [Determinate Nix](https://docs.determinate.systems/determinate-nix/#getting-started).

2. Check out this repo:

   ```
   git clone https://github.com/hsyed/dotfiles ~/.dotfiles
   ```

3. Install Homebrew:

   ```
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

4. Bootstrap nix-darwin:

   ```
   nix run nix-darwin -- switch --flake ~/.dotfiles#personal
   ```

5. Bootstrap home-manager:

   ```
   nix run home-manager -- switch --flake ~/.dotfiles#hsyed@personal
   ```
