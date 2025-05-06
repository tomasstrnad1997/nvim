local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({buffer = bufnr})

	local opts = {buffer = bufnr, remap = false}
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)
lsp_zero.configure('pylsp', {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    maxLineLength=120
                },
                rope_autoimport = {
                    enabled = false
                },
            }
        }
    }
})
lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['pylsp'] = {'python'}
    }
})
require('mason').setup({})
require('mason-lspconfig').setup()
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require('mason-lspconfig').setup({
	ensure_installed = {"lua_ls"},
	handlers = {
        function (server_name)
            require('lspconfig')[server_name].setup({
            capabilities = capabilities,
            on_attach = lsp_zero.on_attach,
            })
        end,
		lsp_zero.default_setup,
		lua_ls = function ()
			require("lspconfig").lua_ls.setup({
				settings = {Lua = {diagnostics = { globals = {"vim"}}}
			}
		})
		end
	},
})
vim.diagnostic.config({
    virtual_text = true
})

