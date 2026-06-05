require("marcuszt")
require("config.lazy")
require("mason").setup()
require("mason-lspconfig").setup()
require("oil").setup()
require("gitsigns").setup()
require('blink.cmp').setup({
    keymap = {
        preset = 'default',
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<Tab>"] = { "accept", "fallback" },
    },
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
