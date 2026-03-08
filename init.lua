vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"
require("core.set")
require("core.latex")
require("core.markdown")
require("core.templates")
require("core.yazi")
require("config.lazy")

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "oxocarbon" } },
  checker = { enabled = true },
})

local cache_path = vim.g.base46_cache
local ok, _ = pcall(vim.fn.readdir, cache_path)

if ok then
  for _, v in ipairs(vim.fn.readdir(cache_path)) do
    dofile(cache_path .. v)
  end
end

