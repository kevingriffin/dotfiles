local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.local/share/nvim/plugged')

--- Language and syntax
Plug 'nathom/filetype.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

--- Movement
Plug 'tpope/vim-unimpaired'
Plug 'easymotion/vim-easymotion'
Plug 'maxbrunsfeld/vim-emacs-bindings'

--- Text editing augmentation
Plug 'ddollar/nerdcommenter'
Plug 'junegunn/vim-easy-align'
Plug 'bronson/vim-trailing-whitespace'
Plug 'terryma/vim-multiple-cursors'
Plug 'AndrewRadev/sideways.vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'mbbill/undotree'
Plug 'ojroques/vim-oscyank'
Plug 'andymass/vim-matchup'

--- Buffer window and file management
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'rbgrouleff/bclose.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'moll/vim-bbye'
Plug 'lambdalisue/fern.vim'
Plug 'Valloric/ListToggle'

--- Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

--- Appearence
Plug 'ellisonleao/gruvbox.nvim'
Plug 'nvim-lualine/lualine.nvim'

--- LSP
Plug 'neovim/nvim-lspconfig'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'lewis6991/impatient.nvim'
Plug 'ms-jpq/coq_nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'

vim.call('plug#end')

-- Fern
vim.keymap.set('n', '<Leader>n', ':Fern . -drawer -toggle<CR>')

vim.cmd [[
nnoremap <leader>n :Fern . -drawer -toggle<CR>
function! FernInit() abort
  " nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> M <Plug>(fern-action-rename)
  nmap <buffer> H <Plug>(fern-action-hidden-toggle)
  " nmap <buffer> r <Plug>(fern-action-reload)
  " nmap <buffer> k <Plug>(fern-action-mark-toggle)j
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  " nmap <buffer><nowait> < <Plug>(fern-action-leave)
  " nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END
]]

-- Telescope
require('telescope').setup {}

-- Search files for visually selected text
function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end

local tb = require('telescope.builtin')

vim.keymap.set('v', '<Leader>r', function()
	local text = vim.getVisualSelection()
	tb.live_grep({ default_text = text })
end, { noremap = true, silent = true })

vim.keymap.set('n', '<C-p>', '<CMD>Telescope find_files<CR>')
vim.keymap.set('n', '<Leader>a', ":lua require'telescope.builtin'.grep_string")
vim.keymap.set('n', '<Leader><CR>', '<CMD>Telescope buffers<CR>')
vim.keymap.set('n', '<Leader>gg',   '<CMD>Telescope live_grep<CR>')
vim.keymap.set('n', '<Leader>m', ":lua require'telescope.builtin'.marks{}<CR>")
vim.keymap.set('n', '<Leader>/', ":lua require'telescope.builtin'.search_history{}<CR>")
vim.keymap.set('n', '<Leader>:', ":lua require'telescope.builtin'.command_history{}<CR>")

-- EasyMotion
vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_smartcase  = 1
vim.keymap.set('n', '<Leader>fi', '<Plug>(easymotion-overwin-f)')
vim.keymap.set('n', '<Leader>ff', '<Plug>(easymotion-overwin-f2)')

-- Sideways.vim
vim.keymap.set('n', ',<', ':SidewaysLeft<CR>')
vim.keymap.set('n', ',>', ':SidewaysRight<CR>')

-- EasyAlign
vim.keymap.set('v', 'ga', '<Plug>(EasyAlign)')
vim.keymap.set('v', 'ga', '<Plug>(EasyAlign)')

-- Vim Multiple Cursors
-- Stay in multiple cursor mode until canceled, for better movement
vim.g.multi_cursor_exit_from_insert_mode = 0

-- Lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
    path = 1,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location', 'encoding', 'filetype'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- Trouble
require("trouble").setup {}
vim.keymap.set('n', '<Leader>t', '<CMD>TroubleToggle<CR>')

-- matchup
vim.g.matchup_matchparen_offscreen = { scrolloff = 1 }

-- impatient
require'impatient'.enable_profile()

-- coq
vim.g.coq_settings = { auto_start = 'shut-up' }

-- gitsigns
require('gitsigns').setup()
