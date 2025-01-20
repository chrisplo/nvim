return {
	"plockc/nvim-lint",
	branch = "all_fixes",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- names are not binary names
		-- https://github.com/mfussenegger/nvim-lint/tree/master/lua/lint/linters
		lint.linters_by_ft = {
			python = { "ruff" },
			go = { "golangcilint" },
		}

		-- copied from https://github.com/mfussenegger/nvim-lint/blob/master/lua/lint/linters/golangcilint.lua
		-- then extended with more linters and test tags
		local lint_go = require("lint").linters.golangcilint
		lint_go.args = {
			"run",
			"--issues-exit-code=0",
			"--enable",
			"predeclared,usestdlibvars,misspell,gocyclo,goconst,gocognit,dupl,copyloopvar",
			"--build-tags",
			"test,testing",
			"--tests",
			"--out-format",
			"json",
			"--show-stats=false",
			"--print-issued-lines=false",
			"--print-linter-name=false",
			function()
				-- gets full file name of current buffer
				-- see with :echo nvim_buf_get_name(0)
				-- then drops the trailing slash with :h
				return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
			end,
		}
		--
		-- figure out staticcheck and shadow

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
