{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      ui-select = {
        enable = true;
        settings = {
          specific_opts = {
            codeactions = true;
          };
        };
      };
    };
    settings.defaults = {
      color_devicons = true;
      file_ignore_patterns = [
        "^.git/"
        "^.mypy_cache/"
        "^__pycache__/"
        "^output/"
        "^data/"
        "%.ipynb"
      ];
    };
  };
}