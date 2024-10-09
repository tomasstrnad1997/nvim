local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local state = require('telescope.actions.state')
require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                ["<C-y>"] = function ()
                    local buf_select = state.get_selected_entry();
                    vim.fn.setreg("", buf_select[1]);
                end
            }
        }
    }
}
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

vim.keymap.set('n', '<leader>ps', function ()
	builtin.grep_string({search = vim.fn.input("Grep > ")})
end)

