{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    package = if pkgs.stdenv.hostPlatform.isDarwin then null else pkgs.zed-editor;
  };

  stylix.targets.zed.enable = false;
}
