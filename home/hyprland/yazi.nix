{ ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    keymap = {
      manager.prepend_keymap = [
        {
          on = "l";
          run = [ "open" "quit --no-cwd-file" ];
          desc = "Open file and quit";
        }
        {
          on = "<Enter>";
          run = [ "open" "quit --no-cwd-file" ];
          desc = "Open file and quit";
        }
      ];
    };
  };
}