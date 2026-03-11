-- ==========================================
-- Templates Rápidos (Carrega arquivos na linha atual)
-- ==========================================
local opts = { silent = true }

-- Yoshi 
vim.keymap.set('n', ',mat0122', ':-1read $HOME/.config/nvim/lua/core/docs/.mat0122.tex<CR>', opts)

-- Carta 
vim.keymap.set('n', ',carta', ':-1read $HOME/.config/nvim/lua/core/docs/.carta.tex<CR>', opts)

-- Anotacoes
vim.keymap.set('n', ',notes', ':-1read $HOME/.config/nvim/lua/core/docs/.notetaking.tex<CR>', opts)

-- Tarefas
vim.keymap.set('n', ',tarefa', ':-1read $HOME/.config/nvim/lua/core/docs/.assignment.tex<CR>', opts)

-- C
vim.keymap.set('n', ',c', ':-1read $HOME/.config/nvim/lua/core/docs/.standard.c<CR>', opts)

-- Maratona
vim.keymap.set('n', ',maratona', ':-1read $HOME/.config/nvim/lua/core/docs/.maratona.cpp<CR>', opts)


-- bash
vim.keymap.set('n', ',shebang', ':-1read $HOME/.config/nvim/lua/core/docs/.shebang.sh<CR>', opts)
