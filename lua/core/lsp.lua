
vim.lsp.config("lua_ls", require("lsp.lua_ls"))
vim.lsp.config("pyright", require("lsp.pyright"))
vim.lsp.config("clangd", require("lsp.clangd"))
vim.lsp.config("texlab", require("lsp.texlab"))
vim.lsp.config("marksman", require("lsp.marksman"))

vim.lsp.enable({
    "lua_ls",
    "pyright",
    "clangd",
    "texlab",
    "marksman"
})

vim.diagnostic.config({
    virtual_lines = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})

local lsp_group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_group,
    desc = 'Atalhos do LSP com Telescope',
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        local builtin = require('telescope.builtin')

        map('<leader>gd', builtin.lsp_definitions, 'Ir para Definição')
        map('<leader>gr', builtin.lsp_references, 'Buscar Referências')
        map('<leader>gI', builtin.lsp_implementations, 'Ir para Implementação')
        map('<leader>gD', builtin.lsp_type_definitions, 'Definição de Tipo')
        map('<leader>gds', builtin.lsp_document_symbols, 'Símbolos do Documento (Variáveis/Funções)')
        map('<leader>ged', builtin.diagnostics, 'Listar Diagnósticos (Erros e Avisos)')
    end,
})
