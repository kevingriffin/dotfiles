local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.local/share/nvim/plugged')

--- Language and syntax
Plug 'nathom/filetype.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

--- Movement
Plug 'tpope/vim-unimpaired'
Plug 'phaazon/hop.nvim'
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
Plug 'windwp/nvim-autopairs'

--- Buffer window and file management
Plug 'nvim-telescope/telescope.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })
Plug 'kyoh86/telescope-windows.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'rbgrouleff/bclose.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'moll/vim-bbye'
Plug 'Valloric/ListToggle'
Plug 'kyazdani42/nvim-tree.lua'

--- Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'TimUntersberger/neogit'
Plug 'sindrets/diffview.nvim'


--- Appearence
Plug 'luisiacc/gruvbox-baby'
Plug 'nvim-lualine/lualine.nvim'

--- LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'lewis6991/impatient.nvim'
Plug 'ms-jpq/coq_nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'jose-elias-alvarez/typescript.nvim'

-- Terminals and tests
Plug 'akinsho/toggleterm.nvim'

-- Fixes
Plug 'antoinemadec/FixCursorHold.nvim'

vim.call('plug#end')

-- autopairs
require("nvim-autopairs").setup {
  map_cr                    = false,
  enable_check_bracket_line = false
}

-- neogit
local neogit = require('neogit')
neogit.setup {
  integrations = {
    diffview = true
  }
}

-- toggleterm
require("toggleterm").setup{
  start_in_insert = false
}
vim.keymap.set('n', '<Leader>t', '<CMD>exe v:count1 . "ToggleTerm"<CR>')

-- nvim-tree
require("nvim-tree").setup()
vim.keymap.set('n', '<Leader>i', ':NvimTreeToggle<CR>')

--bwap
vim.keymap.set('n', '<Leader>ne', ':NavBuffer<CR>')
vim.keymap.set('n', '<Leader>nn', ':SwapBuffer<CR>')
vim.keymap.set('n', '<Leader>nd', ':DeleteBuffer<CR>')

-- Telescope
require('telescope').setup {
  defaults = {
    extensions = {
      fzf = {
        fuzzy                   = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter    = true,     -- override the file sorter
        case_mode               = "smart_case",        -- or "ignore_case" or "respect_case"
      }
    },
    mappings = {
      i = {
        ["<C-Down>"] = require('telescope.actions').cycle_history_next,
        ["<C-Up>"]   = require('telescope.actions').cycle_history_prev,
      },
    },
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('windows')

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
vim.keymap.set('n', '<Leader>ff',   telescope_builtin.live_grep)
vim.keymap.set('n', '<Leader>m',    telescope_builtin.marks)
vim.keymap.set('n', '<Leader>/',    telescope_builtin.search_history)
vim.keymap.set('n', '<Leader>:',    telescope_builtin.command_history)

-- function leap_bidirectional()
--   require'leap'.leap { ['target-windows'] = { vim.api.nvim_get_current_win() } }
-- end

require'hop'.setup()
vim.keymap.set('n', 'z',     '<CMD>HopChar2<CR>', {silent = true})
vim.keymap.set('n', '<S-z>', '<CMD>HopPattern<CR>', {silent = true})

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
    theme = require('lualine-theme'),
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
    path = 1,
     buffers_color = {
        -- Same values as the general color option can be used here.
        active = 'lualine_{section}_normal',     -- Color for active buffer.
        inactive = 'lualine_{section}_normal', -- Color for inactive buffer.
      },
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
vim.keymap.set('n', '<Leader>d', '<CMD>TroubleToggle<CR>')

-- matchup
vim.g.matchup_matchparen_offscreen = { scrolloff = 1 }

-- impatient
require'impatient'.enable_profile()

-- coq
vim.g.coq_settings = { auto_start = 'shut-up' }

-- gitsigns
require('gitsigns').setup()
