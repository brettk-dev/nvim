vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }
		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set("n", "<leader><leader>f", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
		vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = event.buf,
			callback = function()
				vim.lsp.buf.format({
					async = false,
					filter = function(client)
						local do_not_format = { "eslint", "volar" }
						for _, value in pairs(do_not_format) do
							if client.name == value then
								return false
							end
						end
						return true
					end,
				})
			end,
		})
	end,
})

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local default_setup = function(server)
	local server_config = { capabilities = lsp_capabilities }

	if server == "volar" then
		table.insert(server_config, { filetypes = { "vue", "typescript", "javascript" } })
	end

	require("lspconfig")[server].setup(server_config)
end

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "elixirls", "eslint", "lua_ls", "volar" },
	handlers = {
		default_setup,
	},
})

local cmp = require("cmp")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
	},
	mapping = cmp.mapping.preset.insert({
		-- Enter key confirms completion item
		["<CR>"] = cmp.mapping.confirm({ select = false }),

		-- Ctrl + space triggers completion menu
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
})

require("lspconfig").lua_ls.setup({
	capabilities = lsp_capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		},
	},
})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier,
		-- null_ls.builtins.diagnostics.eslint,
	},
})
