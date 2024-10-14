-- LSP config. Adapted from github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)

local configs = require('lspconfig.configs')


local lspconfig = require('lspconfig')

local opts = { noremap=true, silent=true }

nvim_cmp_complete = require('cmp').complete

local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
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
    -- vim.api.nvim_buf_set_option( bufnr, 'omnifunc', 'v:lua.nvim_cmp_complete' )
    vim.keymap.set({'i', 's'}, '<leader>,', require('cmp').complete)
end

-- Using cmp-nvim-lsp instead of native nvim lsp
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

-- nvim-cmp setup
-- Adapted from https://github.com/neovim/nvim-lspconfig/wiki/Snippets
-- TODO See if vim.lsp.completion in nvim 0.11 can replace nvim-cmp
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
        vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      -- behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.snippet.active() then
          vim.snippet.jump(1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.snippet.active() then
        vim.snippet.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }
  }),

  completion = {
      autocomplete = false
  }
}
