-- Hyprland Lua config entry point (hyprlang .conf was deprecated in 0.55,
-- removed in 0.57).
--
-- This directory is out-of-store symlinked to ~/.config/hypr/main (see
-- hyprland.nix), so files here are live-editable without a home-manager
-- switch — run `hyprctl reload` to apply.
--
-- API reference: the shipped stubs at <hyprland>/share/hypr/stubs/hl.meta.lua
-- and https://wiki.hypr.land/Configuring/

require("main.settings")
require("main.binds")
