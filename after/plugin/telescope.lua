local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local state = require('telescope.actions.state')
require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                ["<C-y>"] = function()
                local buf_select = state.get_selected_entry()
                vim.fn.setreg("", buf_select[1])
                end
            }
        }
    }
}
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ht', builtin.help_tags, {})
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pr', builtin.registers, {})
vim.keymap.set('n', '<leader>ps', builtin.spell_suggest, {})
vim.keymap.set('n', '<leader>pm', builtin.marks, {})
vim.keymap.set('n', '<leader>qf', builtin.quickfix, {})
vim.keymap.set('n', '<leader>ma', builtin.keymaps, {})



vim.keymap.set('n', '<leader>ps', function()
               builtin.grep_string({search= vim.fn.input("Grep > ")})
               end)
