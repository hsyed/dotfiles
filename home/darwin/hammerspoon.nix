{ config, ... }:

{
  # Hammerspoon writes runtime state and can reload editable Lua files, so keep
  # the config as a mutable out-of-store symlink into this repo.
  home.file.".hammerspoon".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/darwin/hammerspoon";
}
