_: {
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform,WaylandWindowDecorations"
      "--ozone-platform=wayland"
      "--gtk-version=4"
      "--enable-wayland-ime"
    ];
    extensions = [
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock origin lite
    ];
  };
}
