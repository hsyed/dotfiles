{ pkgs, ... }:
{
  home.packages = [ pkgs.tuicr ];

  xdg.configFile."tuicr/config.toml".text = ''
    diff_watch_interval_ms = 1000

    # First entry is the default when a comment is created.
    comment_types = [
      { id = "comment", definition = "observation or question", color = "cyan" },
      { id = "issue", definition = "problem that must be fixed", color = "red" },
      { id = "praise", definition = "positive feedback", color = "green" },
    ]
  '';
}
