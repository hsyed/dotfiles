This repo contains a Nix flake for various workstations.

# Common resources

The following common files and folders exist in this repo.

* Common home-manager entrypoint `home/home.nix`
* CLI developer tools `home/dev.nix`
* lazyvim dotfiles `home/nvim`

# Systems

## catharsis

* The host `catharsis` is a Linux workstation, check the hostname to determine if running on catharsis
* Nixos configuration in `system/catharsis/configuration.nix`
* home-manager setup including:
  * the Hyprland desktop environment via `home/hyprland`
* nix-ld to enable certain developer tooling which require linking outside the nix store

## Darwin

* VMs and Workstations will be configured from the same derivations, use `uname` to determine if on Darwin.
* `system/darwin.nix` contains the nix-darwin configuration.
* `home/darwin/default.nix` pulls in darwin specific desktop environment stuff
