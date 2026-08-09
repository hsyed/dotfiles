# Fix-forward tracker

Workarounds in this repo that patch around an upstream bug rather than fix it
properly. Each entry should be removed once the referenced upstream issue is
resolved and the workaround is no longer needed.

## Hyprland 0.56 + uwsm: compositor killed by its own session-target restart

- **Where:** `home/hyprland/hyprland.nix` — `wayland.windowManager.hyprland.systemd.extraCommands`
- **What:** Overrides Home Manager's default `extraCommands` (`stop` then
  `start` `hyprland-session.target`) to only run `start`.
- **Why:** Home Manager's Hyprland module runs
  `systemctl --user stop hyprland-session.target && systemctl --user start hyprland-session.target`
  from `exec-once`. Under uwsm, `hyprland-session.target`'s `BindsTo=graphical-session.target`
  propagates that momentary `stop` down through `wayland-session@.target` into
  `wayland-wm@.service`, SIGTERM-ing Hyprland ~100ms after a fully successful
  start. Root-caused upstream in
  [hyprwm/Hyprland#15688](https://github.com/hyprwm/Hyprland/issues/15688)
  (closed as not-a-Hyprland-bug — it's Home Manager's systemd integration).
- **Revert when:** Home Manager's `wayland.windowManager.hyprland` module
  stops emitting a `stop && start` pair for `hyprland-session.target` (or
  gains uwsm-aware handling) — check the module's
  `systemd.extraCommands` default in
  `modules/services/window-managers/hyprland/default.nix` upstream. At that
  point, drop the `systemd.extraCommands` override in `hyprland.nix` and
  delete this entry.
