return {
    {
        "tpope/vim-fugitive",
        config = function()
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<C-G><C-S>", ":Git<CR>", opts)
        end,
    },
    {
        "junegunn/gv.vim",
    }
}