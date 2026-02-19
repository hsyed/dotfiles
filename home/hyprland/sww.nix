{ config, pkgs, ... }:
# swww (swaywall wallpaper daemon) for simple, reliable wallpaper management
# Supports rotating wallpapers with wpaperctl-like functionality via custom script
{
  # Ensure wallpapers directory exists
  home.activation.createWallpaperDir = ''
    mkdir -p "${config.home.homeDirectory}/Pictures/wallpapers"
  '';

  home.packages = with pkgs; [
    swww
  ];

  services.swww = {
    enable = true;
  };

  # Create wallpaper rotation script
  home.file."${config.home.homeDirectory}/.local/bin/swwutil" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      WALLPAPER_DIR="$HOME/Pictures/wallpapers"
      STATE_FILE="$HOME/.cache/swwutil_index"
      
      mkdir -p "$(dirname "$STATE_FILE")"
      
      ALL_PAPERS=($(ls -1 "$WALLPAPER_DIR" | sort))
      PAPER_COUNT=''${#ALL_PAPERS[@]}
      
      if [[ "$1" == "next" ]]; then
        CURRENT_IDX=$(cat "$STATE_FILE" 2>/dev/null || echo 0)
        NEXT_IDX=$(( (CURRENT_IDX + 1) % PAPER_COUNT ))
        echo "$NEXT_IDX" > "$STATE_FILE"
        echo "Loading: ''${ALL_PAPERS[$NEXT_IDX]}" >&2
        swww img "$WALLPAPER_DIR/''${ALL_PAPERS[$NEXT_IDX]}"
      else
        RAND_IDX=$((RANDOM % PAPER_COUNT))
        echo "$RAND_IDX" > "$STATE_FILE"
        echo "Loading: ''${ALL_PAPERS[$RAND_IDX]}" >&2
        swww img "$WALLPAPER_DIR/''${ALL_PAPERS[$RAND_IDX]}"
      fi
    '';
  };
}
