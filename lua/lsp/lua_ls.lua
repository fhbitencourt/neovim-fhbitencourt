return {
    -- Comando exato para rodar o servidor no sistema
    cmd = { "lua-language-server" },
    
    -- Tipos de arquivo onde o LSP deve atuar
    filetypes = { "lua" },
    
    -- Como o Neovim identifica a raiz do projeto para o LSP funcionar
    root_markers = { ".luarc.json", ".git" },
    
    -- Suas configurações específicas
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
}
