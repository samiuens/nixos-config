{
  programs.nixvim.plugins.bufferline = {
    enable = true;
    settings = {
      options = {
        close_command = ''
          function(n) Snacks.bufdelete(n) end
        '';
        rightmouse_command = ''
          function(n) Snacks.bufdelete(n) end
        '';
        always_show_bufferline = false;
        diagnostics = "nvim_lsp";
        diagnostics_indicator = ''
          function(_, _, diag)
            local icons = {
              Error = "󰅙",
              Warn = "",
              Info = "",
              Hint = "💡",
            }

            local ret = ""
            ret = ret .. (diag.error and icons.Error .. diag.error .. " " or "")
            ret = ret .. (diag.warning and icons.Warn .. diag.warning .. " " or "")
            ret = ret .. (diag.info and icons.Info .. diag.info .. " " or "")
            ret = ret .. (diag.hint and icons.Hint .. diag.hint .. " " or "")

            return vim.trim(ret)
          end
        '';
        offsets = [
          {
            filetype = "neo-tree";
            text = "Neo-tree";
            highlight = "Directory";
            text_align = "left";
          }
          {
            filetype = "snacks_layout_box";
          }
        ];
        get_element_icon = ''
          function(opts)
            local mini_icons_ok, mini_icons = pcall(require, "mini.icons")
            if mini_icons_ok and mini_icons.get then
              return mini_icons.get(opts.filetype, nil, true)
            else
              return " "
            end
          end
        '';
      };
    };
  };
}