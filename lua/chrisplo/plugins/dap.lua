return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		opts = {
			ensure_installed = { "delve" },
			handlers = {},
		},
	},
	{
		"leoluz/nvim-dap-go",
		opts = {
			tests = { verbose = true },
		},
	},
	{
		"nvim-neotest/nvim-nio",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap",
		},
		config = function()
			local dapui = require("dapui")
			local dap = require("dap")
			dapui.setup()
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			local km = vim.keymap
			km.set("n", "<F5>", function()
				require("dap").continue()
			end)
			km.set("n", "<F6>", function()
				require("dap").step_over()
			end)
			km.set("n", "<F7>", function()
				require("dap").step_into()
			end)
			km.set("n", "<F8>", function()
				require("dap").step_out()
			end)
			km.set("n", "<Leader>db", function()
				require("dap").set_breakpoint()
			end)
			km.set("n", "<Leader>dB", function()
				require("dap").toggle_breakpoint()
			end)
			km.set("n", "<Leader>dr", function()
				require("dap").repl.open()
			end)
			km.set("n", "<Leader>dw", function()
				dapui.open()
			end)
			km.set("n", "<Leader>dW", function()
				dapui.close()
			end)
		end,
	},
}
