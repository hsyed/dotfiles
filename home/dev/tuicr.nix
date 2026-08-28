{ pkgs, ... }:
{
  home.packages = [ pkgs.tuicr ];

  xdg.configFile."tuicr/config.toml".text = ''
    comment_types = [
      { id = "suggestion", definition = "improvement recommendation", color = "yellow" },
      { id = "note", definition = "observation or question", color = "cyan" },
      { id = "issue", definition = "problem that must be fixed", color = "red" },
      { id = "praise", definition = "positive feedback", color = "green" },
    ]
  '';
}
