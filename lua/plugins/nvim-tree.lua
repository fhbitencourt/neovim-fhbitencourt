return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
    })

    -- Atalho para abrir/fechar o explorador (Ctrl + n)
    vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })
  end,
}
