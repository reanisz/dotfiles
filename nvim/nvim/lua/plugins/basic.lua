return {
    {
        "mhinz/vim-startify",
        config = function()
            vim.cmd([[
                let g:startify_custom_header = map(split(system('date'), '\n'), '"   ". v:val') + ['','']
                let g:startify_bookmarks = [
                            \ '~/.config/nvim/',
                            \ '~/.config/nvim/init.vim',
                            \ '~/.config/nvim/lua/',
                            \ '~/.config/nvim/lua/plugins/',
                            \ ]
        ]])
        end,
    },
    {
        "vim-airline/vim-airline"
    },
    {
        "vim-airline/vim-airline-themes",
        config = function()
            vim.cmd([[
                let g:airline#extensions#tabline#enabled = 1
                let g:airline#extensions#tabline#tab_nr_type = 1

                let g:airline_theme = 'powerlineish'
            ]])
        end,
    },
    {
        "vim-scripts/bufferlist.vim",
        config = function()
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<C-C>", ":call BufferList()<CR>", opts)
        end,
    },
    {
        "tpope/vim-surround",
    }
}