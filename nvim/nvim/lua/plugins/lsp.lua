return {
    { 
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local lspcfg = require("mason-lspconfig")
            lspcfg.setup({
                ensure_installed = {
                    "lua_ls"
                }
            })
        end
    }
}
