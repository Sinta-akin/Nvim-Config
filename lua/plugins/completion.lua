-- lua/plugins/cmp.lua
-- lua/plugins/cmp.lua
return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "onsails/lspkind.nvim", 
        
        -- Node.js / Language Server Prerequisites
        "neovim/nvim-lspconfig",
        {
            "pmizio/typescript-tools.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = {},
        }
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        local compare = require("cmp.config.compare")

        require("luasnip.loaders.from_vscode").lazy_load({})

        -- ---------------------------------------------------------
        -- Node.js LSP Setup
        -- ---------------------------------------------------------
        -- This tells the Node.js language server to send its data to nvim-cmp
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        
        require("typescript-tools").setup({
            capabilities = capabilities,
            settings = {
                -- Fixes auto-imports suggesting absolute paths or weird paths in Node
                typescript = {
                    preferences = {
                        importModuleSpecifierPreference = "non-relative",
                    },
                },
            },
        })

        -- ---------------------------------------------------------
        -- Your Exact CMP Setup
        -- ---------------------------------------------------------
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            completion = {
                keyword_length = 2,
            },

            performance = {
                max_view_entries = 15,
            },

            sources = cmp.config.sources({
                { name = "luasnip", priority = 1000, keyword_length = 1 },
                { name = "nvim_lsp", priority = 850, keyword_length = 2 },
                { name = "buffer", priority = 500 },
                { name = "path", priority = 450 },
            }),

            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4), 
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),

            sorting = {
                comparators = {
                    compare.offset,
                    compare.exact,
                    compare.score,
                    compare.recently_used,
                    compare.locality,
                    compare.kind,
                    compare.length,
                    compare.order,
                },
            },

            experimental = {
                ghost_text = true,
            },

            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text", 
                    maxwidth = 50,
                    ellipsis_char = "...",
                    before = function(entry, item)
                        -- Show Node/LSP details (like auto-import paths) in the menu
                        if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= "" then
                            item.menu = entry.completion_item.detail
                        else
                            local source_labels = {
                                nvim_lsp = "[LSP]",
                                luasnip = "[Snip]",
                                buffer = "[Buf]",
                                path = "[Path]",
                            }
                            item.menu = source_labels[entry.source.name] or ""
                        end
                        return item
                    end,
                }),
            },
        })
    end,
}
