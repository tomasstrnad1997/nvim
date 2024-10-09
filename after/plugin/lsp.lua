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
require('mason-lspconfig').setup({
	ensure_installed = {"lua_ls"},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function ()
			require("lspconfig").lua_ls.setup({
				settings = {Lua = {diagnostics = { globals = {"vim"}}}
			}
		})
		end
	},
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_select = {behavior = cmp.SelectBehavior}

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<C-space>'] = cmp.mapping.confirm({select=true}),

		['<C-b>'] = cmp.mapping.complete(),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	})
})



vim.diagnostic.config({
    virtual_text = true
})

cmp.setup.filetype({ "mysql" }, {
    sources = {
        { name = "vim-dadbod-completion" },
    },
})
