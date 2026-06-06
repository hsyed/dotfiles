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

4. Give the terminal app Full Disk Access.

   The Darwin configuration writes protected macOS accessibility display
   defaults. Give Full Disk Access to the app that will run the bootstrap
   command, such as Terminal, then quit and reopen it. After Ghostty has been
   installed, give Ghostty Full Disk Access as well if it will be used to run
   future nix-darwin switches.

5. Bootstrap nix-darwin:

   ```
   nix run nix-darwin -- switch --flake ~/.dotfiles#personal
   ```

6. Bootstrap home-manager:

   ```
   nix run home-manager -- switch --flake ~/.dotfiles#hsyed@personal
   ```
