{ pkgs, config, ... }:
{
  # Use the Nix-provided Node.js runtime, but keep globally installed npm tools
  # under ~/.npm. This makes it easy to keep fast-moving CLIs such as Claude,
  # Codex, and other global npm tools on their latest upstream versions without
  # waiting for nixpkgs updates.
  programs.npm = {
    enable = true;
    package = pkgs.nodejs;
    settings.prefix = "${config.home.homeDirectory}/.npm";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.npm/bin"
  ];
}
