-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Disable default mappng for window splits moves. <C-w>h/j/k/l to simple <C-h/j/k/l>
-- vim.keymap.del("n", "<C-h>")
-- vim.keymap.del("n", "<C-j>")
-- vim.keymap.del("n", "<C-k>")
-- vim.keymap.del("n", "<C-l>")

-- Cleanup LazyVim window resizing key mappings
vim.keymap.del('n', '<C-Up>')
vim.keymap.del('n', '<C-Down>')
vim.keymap.del('n', '<C-Left>')
vim.keymap.del('n', '<C-Right>')

-- Cleanup LazyVim quickfix list traversal remappings
vim.keymap.del('n', ']q')
vim.keymap.del('n', '[q')

-- vim.keymap.del('n', '<leader>p');

-- Cleanup LazyVim line movements
vim.keymap.del({ 'n', 'i', 'v' }, '<A-j>')
vim.keymap.del({ 'n', 'i', 'v' }, '<A-k>')





-- Move Lines
vim.keymap.set("v", "<S-j>", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "<S-k>", ":m '<-2<cr>gv=gv")


-- " go through quickfix list back and forth
-- nnoremap <C-j> :cnext<CR>
vim.keymap.set('n', '<leader>qj', '<cmd>cnext<CR>')
-- nnoremap <C-k> :cprev<CR>
vim.keymap.set('n', '<leader>gk', '<cmd>cprev<CR>')
-- nnoremap <C-E> :copen<CR>
vim.keymap.set('n', '<leader>qe', '<cmd>copen<CR>')


-- " cleanup search register to remove highlights without disbling hls (highlight search)
-- nmap <C-c> :let @/=""<CR>
vim.keymap.set('n', '<C-c>', '<cmd>let @/=""<CR>')



