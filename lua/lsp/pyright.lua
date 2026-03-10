-- lua/lsp/pyright.lua
return {
    -- Comando executável do servidor no sistema
    cmd = { "pyright-langserver", "--stdio" },
    -- Extensões de arquivo que ativam este servidor
    filetypes = { "python" },
    -- Arquivos que indicam a raiz de um projeto Python
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
    -- Configurações específicas do pyright (opcional)
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
            },
        },
    },
}
