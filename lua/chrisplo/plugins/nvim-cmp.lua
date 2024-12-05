-- import nvim-cmp plugin safely
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

-- load vs-code like snippets from plugins (e.g. friendly-snippets)
require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup({
	-- require navigation to select
	preselect = cmp.PreselectMode.None,
	-- allow snippets
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
	matching = {
		--disallow_partial_fuzzy_matching = false,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		--		["<Tab>"] = cmp.mapping(function(fallback)
		--			if cmp.visible() then
		--				if cmp.complete_common_string() then
		--					return
		--				end
		--				cmp.select_next_item()
		--			-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
		--			-- they way you will only jump inside the snippet region
		--			elseif luasnip.expand_or_jumpable() then
		--				luasnip.expand_or_jump()
		--			else
		--				fallback()
		--			end
		--		end, { "i", "s" }),
		--		["<S-Tab>"] = cmp.mapping(function(fallback)
		--			if cmp.visible() then
		--				cmp.select_prev_item()
		--			elseif luasnip.jumpable(-1) then
		--				luasnip.jump(-1)
		--			else
		--				fallback()
		--			end
		--		end, { "i", "s" }),
	}), -- sources for autocompletion
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- lsp
		-- { name = "luasnip" }, -- snippets
	}, {
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	}),
	-- configure lspkind for vs-code like icons
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
})