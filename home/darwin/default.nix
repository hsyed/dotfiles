{ ... }:

{
  imports = [
    ../apps/ghostty.nix
    ../apps/zed.nix
  ];

  services.jankyborders = {
    enable = true;
    settings = {
      style = "round";
      width = 6.0;
      hidpi = "off";
      active_color = "0xffffb86c";
      inactive_color = "0xff4a3025";
    };
  };
}
