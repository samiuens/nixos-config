{ lib, pkgs, ... }: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      cursor_shape = "underline";
      mouse_hide_wait = -1;
      remember_window_size = true;
      tab_bar_edge = "top";
      tab_bar_style = "slant";
    };
    keybindings =
      let
        superKey =
          if pkgs.stdenv.isDarwin then "cmd"
          else "ctrl";
      in
      {
        "${superKey}+1" = "goto_tab 1";
        "${superKey}+2" = "goto_tab 2";
        "${superKey}+3" = "goto_tab 3";
        "${superKey}+4" = "goto_tab 4";
        "${superKey}+5" = "goto_tab 5";
        "${superKey}+6" = "goto_tab 6";
        "${superKey}+7" = "goto_tab 7";
        "${superKey}+8" = "goto_tab 8";
        "${superKey}+9" = "goto_tab 9";
        "${superKey}+w" = "close_tab";
        "${superKey}+t" = "new_tab_with_cwd";
      };
  };
}