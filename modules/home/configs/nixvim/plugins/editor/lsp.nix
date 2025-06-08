{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      jsonls.enable = true;
      marksman.enable = true;
      vimls.enable = true; 
      eslint.enable = true;
      statix.enable = true;
    };
  };
}