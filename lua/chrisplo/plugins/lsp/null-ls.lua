-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- this i think was for FSO where the imports were relative which isn't really allowed
-- local golangci_lint = require("chrisplo.plugins.lsp.golangci-lint")

null_ls.setup({
	debug = true,
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes = {}})" (see null-ls docs)
		formatting.prettier, -- js/ts formatter
		formatting.stylua, -- lua formatter
		diagnostics.golangci_lint, -- golang diagnostics
		-- this i think was for FSO where the imports were relative which isn't really allowed
		-- golangci_lint, -- golang linter that only runs on $FILENAME instead of $ROOT
		formatting.goimports, -- golang import formatter
		formatting.gofmt,
			diagnostics.eslint_d.with({ -- js/ts linter
				-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
				condition = function(utils)
					return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
				end,
			}),
	},
	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
						timeout_ms = 2000,
					})
				end,
			})
		end
	end,
})
