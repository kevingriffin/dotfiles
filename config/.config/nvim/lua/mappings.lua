-- Move to alternate buffer with double leader
vim.keymap.set('n', '<Leader>bb', '<C-^>')

-- Use tab in normal mode to go through splits
vim.keymap.set('n', '<Tab>',   '<C-W><C-W>')
vim.keymap.set('n', '<S-Tab>', '<C-W>W')

-- Exit terminal a bit easier
vim.keymap.set('t', '<C-\\><C-\\>', '<C-\\><C-N>')

-- Easier balance windows
vim.keymap.set('n', '<Leader>=', '<C-W>=')

-- Split nativation
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')

-- Resize splits
if vim.fn.bufwinnr(1) then
  vim.keymap.set('n', '<S-A-J>', '<C-W>+')
  vim.keymap.set('n', '<S-A-K>', '<C-W>-')
  vim.keymap.set('n', '<S-A-L>', '<C-W>>')
  vim.keymap.set('n', '<S-A-H>', '<C-W><')
end

-- Copy to the system clipboard easily
vim.keymap.set('v', '<Leader>y', '"+y')

-- Put the current file path onto the system clipboard
vim.keymap.set('n', 'cf', ':let @+ = expand("%")<CR>')

-- Replace inner selections
vim.keymap.set('n', '<Leader>ri\'', 'vi\'p')
vim.keymap.set('n', '<Leader>ri"', 'vi\"p')

-- Push selection to file for copy elsewhere (via ssh)
vim.keymap.set('v', '<Leader>z', ':w! /tmp/clip<CR>')

-- Paste the most recently copied (not deleted) item
vim.keymap.set('n', '<Leader>y',  '"0y<CR>')
vim.keymap.set('n', '<Leader>pp', '"0p<CR>')
vim.keymap.set('n', '<Leader>PP', '"0P<CR>')
