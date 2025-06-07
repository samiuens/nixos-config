{ pkgs, ... }: {
  programs.nixvim.plugins.treesitter = {
    enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      javascript
      json
      markdown
      nix
      regex
      typescript
      vim
      vimdoc
    ];
  };
}