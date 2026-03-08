local md_group = vim.api.nvim_create_augroup("MarkdownWorkflow", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = md_group,
  -- Aplica para markdown e pandoc
  pattern = { "markdown", "pandoc" },
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }

    -- 1. Compilar para PDF usando Pandoc (<leader>c)
    vim.keymap.set('n', '<leader>c', function()
      local current_file = vim.fn.expand("%")
      local pdf_file = vim.fn.expand("%:r") .. ".pdf"
      vim.notify("Compilando Markdown via Pandoc...", vim.log.levels.INFO)
      vim.fn.jobstart({ "pandoc", current_file, "-o", pdf_file }, {
        on_exit = function(_, code)
          if code == 0 then
            vim.notify("Markdown compilado com sucesso!", vim.log.levels.INFO)
          else
            vim.notify("Erro ao compilar Markdown.", vim.log.levels.ERROR)
          end
        end
      })
    end, opts)

    -- 2. Abrir PDF no Zathura (<leader>S) - A mesma memória muscular do LaTeX!
    vim.keymap.set('n', '<leader>S', function()
      local pdf_file = vim.fn.expand("%:r") .. ".pdf"
      vim.fn.jobstart({ "zathura", pdf_file }, { detach = true })
    end, opts)

    -- 3. Alternar Checkbox de Tarefas (<leader>x)
    -- Troca [ ] por [x], ou adiciona um checkbox se a linha não tiver
    vim.keymap.set('n', '<leader>x', function()
      local line = vim.api.nvim_get_current_line()
      if line:match("%[ %]") then
        vim.api.nvim_set_current_line(line:gsub("%[ %]", "[x]", 1))
      elseif line:match("%[x%]") then
        vim.api.nvim_set_current_line(line:gsub("%[x%]", "[ ]", 1))
      else
        -- Adiciona um checkbox vazio no início se não existir
        vim.api.nvim_set_current_line("- [ ] " .. line)
      end
    end, opts)

    -- 4. Inserir Bloco de Código Rápido (<C-b>)
    -- Semelhante ao de \begin{} do LaTeX
    vim.keymap.set('n', '<C-b>', 'O```<CR>```<Esc>O', opts)
    -- 5. Live Preview no Navegador (<leader>p)
    vim.keymap.set('n', '<leader>p', ':MarkdownPreviewToggle<CR>', opts)
  end,
})
