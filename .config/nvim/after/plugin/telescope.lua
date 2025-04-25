local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Fuzzy find files in the whole project.' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Find files in git.' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string( { search = vim.fn.input("Grep > ") });
end)
