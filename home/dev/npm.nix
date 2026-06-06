{
  pkgs,
  config,
  lib,
  ...
}:
let
  globalNpmPackages = [
    "@anthropic-ai/claude-code"
    "@openai/codex"
    "hunkdiff"
  ];

  npmPackagesStr = builtins.concatStringsSep " " globalNpmPackages;
  npmPackagesHash = builtins.hashString "sha256" npmPackagesStr;
  npmDir = "${config.home.homeDirectory}/.npm";
  sentinel = "${npmDir}/.global-packages-hash";
in
{
  # Use the Nix-provided Node.js runtime, but keep globally installed npm tools
  # under ~/.npm. This makes it easy to keep fast-moving CLIs such as Claude,
  # Codex, and other global npm tools on their latest upstream versions without
  # waiting for nixpkgs updates.
  #
  # To add a new global npm package, append it to globalNpmPackages above. The
  # next switch will hash the list, detect the change via a sentinel file, and
  # run `npm install --location=global` only when the list actually changed.
  programs.npm = {
    enable = true;
    package = pkgs.nodejs;
    settings.prefix = "${config.home.homeDirectory}/.npm";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.npm/bin"
  ];

  home.activation.installGlobalNpmPackages = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    echo "checking global npm packages (sentinel: ${sentinel})..."
    if [ -f "${sentinel}" ] && [ "$(cat '${sentinel}')" = "${npmPackagesHash}" ]; then
      echo "  -> packages unchanged, nothing to do"
    else
      echo "  -> installing: ${npmPackagesStr}"
      run mkdir -p "${npmDir}"
      run env PATH="${pkgs.nodejs}/bin:$PATH" npm install --location=global ${npmPackagesStr}
      echo '${npmPackagesHash}' > '${sentinel}'
    fi
  '';
}
