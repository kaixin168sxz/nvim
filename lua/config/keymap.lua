-- define common options
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}
local map = vim.keymap.set

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- set `<Esc>` to disable search highlight
map('n', '<Esc>', ':nohl<CR>', opts)

-- use `jk` to back to NORMAL mode
map('i', 'jk', '<Esc>', opts)

-- Resize with arrows
-- delta: 2 lines
map('n', '<C-Up>', ':resize -2<CR>', opts)
map('n', '<C-Down>', ':resize +2<CR>', opts)
map('n', '<C-Left>', ':vertical resize -2<CR>', opts)
map('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- 添加缩进，添加后光标位置不会回到起始位置，如`v8j>`后，光标会停留在8行下
-- Hint: start visual mode with the same area as the previous area and the same mode
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-------------------
-- telescope key --
-------------------

local builtin = require('telescope.builtin')
map('n', '<leader><space>', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

------------------
-- other keymap --
------------------

map("n", "<leader>bd", function()
    Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

map("n", "<leader>tn", ":FloatermNew<CR>")
map("n", "<leader>tr", ":FloatermNew! ra<CR>")
map("n", "<leader>tb", ":FloatermNew bash<CR>")
