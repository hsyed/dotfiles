{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.neovim
  ];

  # This creates a symlink which ultimately resolves to the ~/.dotfile directory.
  # The config can't be immutable as lazy uses a lock file. A better approach for
  # lazyvim config might just be to have a manual script to setup symlinks for cases
  # like lazyvim. Or moving vim config to the flake.
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/nvim";
  };
}
