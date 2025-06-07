{
  programs.nixvim.plugins.noice = {
    enable = true;
    settings = {
      lsp.overrides = {
        "vim.lsp.util.convert_input_to_markdown_line" = true;
        "vim.lsp.util.stylize_markdown" = true;
        #"cmp.entry.get_documentation" = true;
      };
      presets = {
        "bottom_search" = true;
        "command_palette" = true;
        "long_message_to_split" = true;
      };
    };
  };
}