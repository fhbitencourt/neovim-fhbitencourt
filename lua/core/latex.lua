-- Cria um grupo para agrupar as configurações de LaTeX
local tex_group = vim.api.nvim_create_augroup("LaTeXWorkflow", { clear = true })

-- Aplica os atalhos APENAS quando o arquivo for do tipo 'tex' ou 'plaintex'
vim.api.nvim_create_autocmd("FileType", {
  group = tex_group,
  pattern = { "tex", "plaintex" },
  callback = function(event)
    -- A opção 'buffer = event.buf' garante que o atalho só exista na aba atual
    local opts = { buffer = event.buf, silent = true }

    -- 1. Compilar com latexmk (<leader>c)
    vim.keymap.set('n', '<leader>c', ':w<CR>:!latexmk -pdf "%"<CR><CR>', opts)

    -- 2. Abrir PDF no Zathura (<leader>S)
    vim.keymap.set('n', '<leader>S', function()
      -- Pega o nome do arquivo sem a extensão (.tex) e adiciona .pdf
      local pdf_file = vim.fn.expand("%:r") .. ".pdf"
      -- Roda o zathura silenciosamente no background do Neovim
      vim.fn.jobstart({ "zathura", pdf_file }, { detach = true })
    end, opts)

    -- 3. Limpar arquivos auxiliares (<leader>C)
    vim.keymap.set('n', '<leader>C', ':!latexmk -c "%"; rm -f "%:r.nav" "%:r.snm"<CR><CR>', opts)

    -- 4. Macro para criar blocos \begin{} ... \end{} (<C-B>)
    vim.keymap.set({ 'n', 'v' }, '<C-b>', 'YpkI\\begin{<ESC>A}<ESC>jI\\end{<ESC>A}<ESC>kA', opts)
    vim.keymap.set('i', '<C-b>', '<ESC>YpkI\\begin{<ESC>A}<ESC>jI\\end{<ESC>A}<ESC>kA', opts)
  end,
})
