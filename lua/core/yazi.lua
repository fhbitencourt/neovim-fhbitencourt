-- 1. Integração com Yazi (Função)
local function yazi_chooser(open_cmd)
  -- Captura o caminho completo do arquivo que você está editando agora 
  local current_file = vim.fn.expand('%:p')
  -- Se o buffer estiver vazio (sem arquivo), abre no diretório atual (cwd) 
  if current_file == "" then
    current_file = vim.fn.getcwd()
  end
  local tmp_file = vim.fn.tempname()
  -- Passa o arquivo/diretório atual para o Yazi focar nele [cite: 8]
  local cmd = string.format('yazi "%s" --chooser-file="%s"', current_file, tmp_file)

  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded"
  })

  vim.fn.termopen(cmd, {
    on_exit = function()
      vim.api.nvim_win_close(win, true)
      
      if vim.fn.filereadable(tmp_file) == 1 then
        local selected_file = vim.fn.readfile(tmp_file)[1]
        if selected_file and selected_file ~= "" then
          vim.cmd(open_cmd .. ' ' .. vim.fn.fnameescape(selected_file))
        end
        vim.fn.delete(tmp_file)
      end
    end
  })
  vim.cmd("startinsert")
end

-- 2. Atalhos Manuais 
local opts = { silent = true }

-- Atalhos originais 
vim.keymap.set('n', '<leader>cd', function() yazi_chooser('tabnew') end, opts)
vim.keymap.set('n', '<leader>vs', function() yazi_chooser('vsplit') end, opts)

-- Navegação rápida entre janelas (Splits) - Ctrl + direção 
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Gerenciamento de abas 
vim.keymap.set("n", "<leader>l", ":tabnext<CR>", opts)
vim.keymap.set("n", "<leader>h", ":tabprevious<CR>", opts)
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", opts)
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", opts)


