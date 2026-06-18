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
		"onsails/lspkind.nvim", -- replaces your lspkind.enable = true
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		local compare = require("cmp.config.compare")

		require("luasnip.loaders.from_vscode").lazy_load({})

		cmp.setup({
			-- snippet expand (from your snippet.expand block)
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			-- completion.keyword_length = 2 (global default)
			completion = {
				keyword_length = 2,
			},

			-- performance.max_view_entries = 15
			performance = {
				max_view_entries = 15,
			},

			-- sources with priorities and per-source keyword_length (from your sources list)
			sources = cmp.config.sources({
				{ name = "luasnip", priority = 1000, keyword_length = 1 },
				{ name = "nvim_lsp", priority = 850, keyword_length = 2 },
				{ name = "buffer", priority = 500 },
				{ name = "path", priority = 450 },
			}),

			-- mapping translated from your NixVim mapping block
			-- Tab/S-Tab kept smart (snippet-aware) rather than plain select,
			-- because plain select_next_item() breaks snippet jumping.
			-- Everything else is a direct 1:1 translation.
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4), -- your <C-d>, not <C-b>
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

			-- sorting.comparators (exact order from your config)
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

			-- experimental.ghost_text = true
			experimental = {
				ghost_text = true,
			},

			-- formatting using lspkind (replaces your manual icons table)
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text", -- show icon + type name
					maxwidth = 50,
					ellipsis_char = "...",
					before = function(entry, item)
						-- optional: tag the source name in the menu column
						local source_labels = {
							nvim_lsp = "[LSP]",
							luasnip = "[Snip]",
							buffer = "[Buf]",
							path = "[Path]",
						}
						item.menu = source_labels[entry.source.name] or ""
						return item
					end,
				}),
			},
		})
	end,
}
