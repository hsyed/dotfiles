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

## Zed Delta: installed from Zed's flake instead of nixpkgs

- **Where:** `flake.nix` — `inputs.delta`; `home/hyprland/default.nix` —
  `inputs.delta.packages.<system>.delta` in `home.packages`.
- **What:** Pulls Zed's Delta from the official
  [zed-industries/delta-nix](https://github.com/zed-industries/delta-nix)
  flake (prebuilt Linux binaries, built-in updater disabled).
- **Why:** Delta is not packaged in nixpkgs yet. Note that nixpkgs `delta` is
  the unrelated git diff pager.
- **Revert when:** Zed's Delta lands in nixpkgs (search nixpkgs for a
  `zed-delta`-style attribute). At that point, swap the package reference for
  the nixpkgs one, drop the `delta` input from `flake.nix`, the `inputs`
  argument in `home/hyprland/default.nix` if unused, and delete this entry.

## Determinate Nix pinned to 3.22: nom can't parse 3.23 logs

- **Where:** `flake.nix` — `inputs.determinate.url` (`3.22.*` instead of `*`).
- **What:** Holds Determinate Nix at 3.22.x.
- **Why:** Determinate Nix 3.23 emits `internal-json` activity type `10113`
  (named activities), which nix-output-monitor 2.2.0 rejects with
  `invalid activity type: 10113`, spamming every `nh` switch. Tracked in
  [maralorn/nix-output-monitor#320](https://github.com/maralorn/nix-output-monitor/issues/320);
  fixed upstream by [PR #321](https://github.com/maralorn/nix-output-monitor/pull/321)
  (merged 2026-10-19, unreleased) and patched into nixpkgs' 2.2.0 by
  [NixOS/nixpkgs#576147](https://github.com/NixOS/nixpkgs/pull/576147)
  (merged to `master` 2026-10-21, merge commit `b1b7e1f0`). Determinate closed
  their side as
  [nix-src#659](https://github.com/DeterminateSystems/nix-src/issues/659).
- **Revert when:** the locked nixpkgs contains nixpkgs#576147. The version
  stays 2.2.0, so check the commit instead:
  `gh api repos/NixOS/nixpkgs/compare/b1b7e1f0fb61b4705f43257dfefedbc814734193...<locked nixpkgs rev> -q .status`
  must print `ahead` or `identical`. At that point, set the URL back to
  `determinate/*`, run `nix flake update determinate`, and delete this entry.
