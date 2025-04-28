-- use ,, to trigger omnifunc
vim.keymap.set({'i','s'}, '<leader>,', '<C-x><C-o>')

vim.lsp.config = {
    clangd = {
        cmd = { "clangd", "--completion-style=detailed" },
        filetypes = {'c', 'cpp'},
    },
}

vim.lsp.enable({'clangd'})

-- https://neovim.io/doc/user/lsp.html#lsp-attach
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/completion') then

        vim.lsp.completion.enable(true, args.data.client_id, 0, {autotrigger = true})

        vim.keymap.set({'i','s'}, '<Tab>', function()
            -- Select completion if popup menu is visible
            if vim.fn.pumvisible() ~= 0 then
                return '<C-y>'
            -- Jump through snippet placeholders if snippet is active
            elseif vim.snippet.active { direction = 1 } then
                return '<Cmd>lua vim.snippet.jump(1)<CR>'
            else
                return '<Tab>'
            end
        end, {buffer = true, expr = true, silent = true})

        vim.keymap.set({'i','s'}, '<S-Tab>', function()
            if vim.snippet.active { direction = -1 } then
                return '<Cmd>lua vim.snippet.jump(-1)<CR>'
            else
                return '<S-Tab>'
            end
        end, {buffer = true, expr = true, silent = true})
    end

    if client:supports_method('textDocument/definition') then
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=true})
    end

    if client:supports_method('textDocument/codeAction') then
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {buffer = true})
    end

    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {buffer = true})
end
})
