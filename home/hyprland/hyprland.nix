{ config, pkgs, ... }:
{
  # Hyprland 0.56.x: the default exec-once does
  #   systemctl --user stop hyprland-session.target &&
  #   systemctl --user start hyprland-session.target
  # The "stop" propagates via BindsTo= through graphical-session.target
  # into wayland-wm@.service, killing Hyprland itself with SIGTERM ~100ms
  # after startup. See: https://github.com/hyprwm/Hyprland/issues/15688
  wayland.windowManager.hyprland.systemd.extraCommands = [
    "systemctl --user start hyprland-session.target"
  ];

  # Live-editable Lua config, same pattern as nvim: ~/.config/hypr/main is an
  # out-of-store symlink to ./lua in this repo. Edit + `hyprctl reload`, no
  # home-manager switch needed.
  xdg.configFile."hypr/main".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/hyprland/lua";

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    # hyprlang .conf configs are deprecated since Hyprland 0.55 (removed in
    # 0.57). configType defaults to "hyprlang" while home.stateVersion < 26.05,
    # so opt in to the Lua backend explicitly.
    configType = "lua";

    # The module only sets up package.path when extraLuaFiles is used, so do it
    # here before loading the symlinked config (./lua/init.lua).
    extraConfig = ''
      local hypr_dir = (os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")) .. "/hypr"
      package.path = hypr_dir .. "/?.lua;" .. hypr_dir .. "/?/init.lua;" .. package.path
      require("main")
    '';
  };
}
