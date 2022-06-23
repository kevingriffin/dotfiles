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
Plug 'nvim-lua/lsp-status.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'lewis6991/impatient.nvim'
Plug 'ms-jpq/coq_nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

vim.call('plug#end')

-- Fern
vim.keymap.set('n', '<Leader>n', ':Fern . -drawer -toggle<CR>')

vim.cmd [[
nnoremap <leader>n :Fern . -drawer -toggle<CR>
function! FernInit() abort
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> M <Plug>(fern-action-rename)
  nmap <buffer> H <Plug>(fern-action-hidden-toggle)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END
]]

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-Down>"] = require('telescope.actions').cycle_history_next,
        ["<C-Up>"]   = require('telescope.actions').cycle_history_prev,
      },
    },
  }
}

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

local telescope_builtin = require 'telescope.builtin'

vim.keymap.set('n', '<C-p>',        telescope_builtin.find_files)
vim.keymap.set('n', '<C-S-p>',      telescope_builtin.resume)
vim.keymap.set('n', '<Leader>a',    telescope_builtin.grep_string)
vim.keymap.set('n', '<Leader><CR>', telescope_builtin.buffers)
vim.keymap.set('n', '<Leader>lg',   telescope_builtin.live_grep)
vim.keymap.set('n', '<Leader>m',    telescope_builtin.marks)
vim.keymap.set('n', '<Leader>/',    telescope_builtin.search_history)
vim.keymap.set('n', '<Leader>:',    telescope_builtin.command_history)

-- EasyMotion
vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_smartcase  = 1
vim.keymap.set('n', '<Leader>fi', '<Plug>(easymotion-overwin-f)')
vim.keymap.set('n', '<Leader>ff', '<Plug>(easymotion-overwin-f2)')

-- EasyAlign
vim.keymap.set('v', 'ga', '<Plug>(EasyAlign)')
vim.keymap.set('v', 'ga', '<Plug>(EasyAlign)')

-- Vim Multiple Cursors
-- Stay in multiple cursor mode until canceled, for better movement
vim.g.multi_cursor_exit_from_insert_mode = 0

-- Lualine
lsp_status = require('lsp-status')

function LspStatus()
  if #vim.lsp.buf_get_clients() < 1 then return "" end

  return lsp_status.status()
end

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
    lualine_y = {'LspStatus()', 'location'},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {'location'},
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
