{
  imports =
    [
      # Editor
      ./editor/lsp.nix
      ./editor/telescope.nix
      ./editor/treesitter.nix
      
      # Git
      ./git/gitsigns.nix

      # Packages
      ./packages/lz-n.nix

      # UI
      ./ui/bufferline.nix
      ./ui/lualine.nix
      ./ui/noice.nix
      ./ui/nui.nix
      ./ui/snacks.nix
      ./ui/trouble.nix

      # Utils
      ./utils/mini.nix
      ./utils/persistence.nix
      ./utils/which-key.nix
    ];
}