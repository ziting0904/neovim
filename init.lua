require("marcuszt")
require("config.lazy")
require("mason").setup()
require("mason-lspconfig").setup()
require("oil").setup()
require("gitsigns").setup()
require('blink.cmp').setup({
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
})

local lsp_configs = {}
for _, f in pairs(vim.api.nvim_get_runtime_file('lsp/*.lua', true)) do
    require("config.lazy")
    local server_name = vim.fn.fnamemodify(f, ':t:r')
    table.insert(lsp_configs, server_name)
end

local capabilities = require('blink.cmp').get_lsp_capabilities()
vim.lsp.config("*", { capabilities = capabilities })
vim.lsp.enable(lsp_configs)
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {
                    'vim',
                    'require'
                },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

vim.cmd.colorscheme "catppuccin-mocha"
build = function() require('blink.cmp').build():wait(60000) end
