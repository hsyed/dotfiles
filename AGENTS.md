This repo contains a Nix flake for various workstations.

# Nix helpers

Shell aliases defined in `home/dev/default.nix` for managing the flake:

| Alias | Command | Purpose |
|---|---|---|
| `nx.fmt` | `nix fmt` | Format all nix files |
| `nx.verify` | `nix flake check` | Verify the flake |
| `nx.sys.switch` | `nh darwin/os switch` | Rebuild and switch system config |
| `nx.home.switch` | `nh home switch` | Rebuild and switch home-manager config |
| `nx.clean` | `nh clean all --keep 10` | Remove old generations (keeps 10) |

# Common resources

The following common files and folders exist in this repo.

* Common home-manager entrypoint `home/home.nix`
* CLI developer tools `home/dev/default.nix`
* lazyvim dotfiles `home/nvim`

# Conventions and principles

## Dev modules

Keep `home/dev/default.nix` focused on simple shared developer tools. If a tool
touches multiple configuration branches, needs non-standard setup such as
out-of-store symlinks, or requires enough config/comments to document its
behavior, split it into a focused module under `home/dev/` and import it from
`home/dev/default.nix`.

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
