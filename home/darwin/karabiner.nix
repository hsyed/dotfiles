{ config, ... }:

{
  home.file.".config/karabiner/karabiner.json" = {
    force = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/darwin/karabiner/karabiner.json";
  };
}
