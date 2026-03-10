vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"
require("core.set")
require("core.latex")
require("core.markdown")
require("core.templates")
require("core.yazi")
require("config.lazy")
require("core.lsp")

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "oxocarbon" } },
  checker = { enabled = true },
})

local cache_path = vim.g.base46_cache

if vim.fn.isdirectory(cache_path) == 1 then
  for _, v in ipairs(vim.fn.readdir(cache_path)) do
    dofile(cache_path .. v)
  end
end
