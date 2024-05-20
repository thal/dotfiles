-- LSP config. Adapted from github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
-- Default in nvim 0.10
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

local lspconfig = require('lspconfig')
local opts = { noremap=true, silent=true }

local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    -- Default in nvim 0.10
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
        vim.inspect(vim.lsp.buf.list_workspace_folders())
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
    -- vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})

    vim.api.nvim_buf_set_option( bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc' )
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- lspconfig.pyright.setup {
--     on_attach = on_attach,
--     capabilities = capabilities
-- }

lspconfig.rust_analyzer.setup{
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true;
      }
    },
  },
  on_attach = on_attach,
  capabilities = capabilities
}

lspconfig.clangd.setup {
    cmd = {"clangd", "--log=verbose"},
    on_attach = on_attach,
    capabilities = capabilities
}

