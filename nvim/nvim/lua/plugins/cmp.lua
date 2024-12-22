return {
    { 
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require "cmp"
            local map = cmp.mapping

            cmp.setup {
                snippet = {
                },
                window = {
                },
                mapping = map.preset.insert {
                ['<C-Space>'] = map.complete(),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "lazedev", group_index = 0 },
                    { name = "buffer" },
                });
            }
        end
    },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
}