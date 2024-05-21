-- LSP config. Adapted from github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)

local configs = require('lspconfig.configs')

configs.dts = {
    default_config = {
        cmd = { 'python3', '/home/tom/code/dt-lsp/server.py'},
        filetypes = {'dts'},
        root_dir = function(buffer_dir)
            return vim.fn.getcwd()
        end
    }
}

local nvim_lsp = require('lspconfig')

local opts = { noremap=true, silent=true }

local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
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

nvim_lsp.rust_analyzer.setup{
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

nvim_lsp.clangd.setup {
    cmd = {"clangd", "--log=verbose"},
    on_attach = on_attach,
    capabilities = capabilities
}

nvim_lsp.dts.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
