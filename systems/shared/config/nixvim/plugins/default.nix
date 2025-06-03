{
  imports =
    [
      # Editor
      ./plugins/editor/lsp.nix
      ./plugins/editor/telescope.nix
      ./plugins/editor/treesitter.nix
      
      # Git
      ./plugins/git/gitsigns.nix

      # Packages
      ./plugins/packages/lz-n.nix

      # UI
      ./plugins/ui/bufferline.nix
      ./plugins/ui/lualine.nix
      ./plugins/ui/noice.nix
      ./plugins/ui/nui.nix
      ./plugins/ui/snacks.nix

      # Utils
      ./plugins/utils/mini.nix
      ./plugins/utils/persistence.nix
      ./plugins/utils/which-key.nix
    ];
}