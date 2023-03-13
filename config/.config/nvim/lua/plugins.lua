local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.local/share/nvim/plugged')

-- Mini
Plug 'echasnovski/mini.nvim'

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
Plug 'terryma/vim-multiple-cursors'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'mbbill/undotree'
Plug 'ojroques/vim-oscyank'
Plug 'andymass/vim-matchup'
Plug 'windwp/nvim-autopairs'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'machakann/vim-sandwich'
Plug 'windwp/nvim-ts-autotag'
Plug 'sitiom/nvim-numbertoggle'
Plug 'smjonas/inc-rename.nvim'
Plug 'Wansmer/treesj'

--- Buffer window and file management
Plug 'nvim-telescope/telescope.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
Plug 'kyoh86/telescope-windows.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'rbgrouleff/bclose.vim'
Plug 'sindrets/winshift.nvim'
Plug 'moll/vim-bbye'
Plug 'Valloric/ListToggle'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kevinhwang91/nvim-bqf'
Plug "cbochs/portal.nvim"

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
Plug 'https://gitlab.com/yorickpeterse/nvim-dd.git'
Plug 'RRethy/nvim-treesitter-endwise'
Plug 'nvim-treesitter/playground'

-- Terminals and tests
Plug 'akinsho/toggleterm.nvim'

-- Fixes
Plug 'antoinemadec/FixCursorHold.nvim'

vim.call('plug#end')

-- impatient
require'impatient'

-- Mini

local sessions = require('mini.sessions')
sessions.setup({
  autoread  = false,
  autowrite = false,
  directory = '~/.local/share/nvim/sessions',
  force = { read = false, write = true, delete = false }
})

-- use the path as a session file, but don't put
-- literal slashes into the filename to make it easier
-- to use
local writeSession = function()
  path = string.gsub(vim.fn.getcwd(), "/", "_")
  sessions.write(path)
end

vim.keymap.set('n', '<Leader>se', writeSession)

require('mini.starter').setup({
  evaluate_single = true
})

require('mini.trailspace').setup({})

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*' },
    callback = function()
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
    end
})

-- vim sandwich

-- Add leader to mappings to avoid slowing down vim's
-- substitue ('s') mapping
vim.g.sandwich_no_default_key_mappings          = true
vim.g.operator_sandwich_no_default_key_mappings = true

vim.keymap.set('',  '<Leader>sa', '<Plug>(operator-sandwich-add)')
vim.keymap.set('x', '<Leader>sd', '<Plug>(operator-sandwich-delete)')
vim.keymap.set('x', '<Leader>sr', '<Plug>(operator-sandwich-replace)')
vim.keymap.set('n', '<Leader>sd', '<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)')
vim.keymap.set('n', '<Leader>sr', '<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)')
vim.keymap.set('n', '<Leader>sd', '<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)')
vim.keymap.set('n', '<Leader>sr', '<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)')


-- nvim-dd

-- Load diagnostics instantly in normal
-- mode but not in insert mode, to avoid
-- trouble.nvim breaking coq_nvim
require('dd').setup({
  timeout = 0
})


-- winshift
require("winshift").setup()
vim.keymap.set('',  '<C-W><C-M>', '<Cmd>WinShift<CR>')
vim.keymap.set('',  '<C-W>m', '<Cmd>WinShift<CR>')

vim.keymap.set('',  '<C-W>X',  '<Cmd>WinShift swap<CR>')
vim.keymap.set('',  '<C-M-H>', '<Cmd>WinShift left<CR>')
vim.keymap.set('',  '<C-M-J>', '<Cmd>WinShift down<CR>')
vim.keymap.set('',  '<C-M-K>', '<Cmd>WinShift up<CR>')
vim.keymap.set('',  '<C-M-L>', '<Cmd>WinShift right<CR>')


-- autopairs
local npairs = require('nvim-autopairs')
local remap = vim.api.nvim_set_keymap

npairs.setup {
  map_cr                    = false,
  map_bs                    = false,
  enable_check_bracket_line = false
}

-- Remap CR and BS to work with autopairs
-- Specifically, this allows indent to keep working
-- when an autopaired character is present when pressing CR

vim.g.coq_settings = { keymap = { recommended = false } }

remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

-- neogit
local neogit = require('neogit')
neogit.setup {
  integrations = {
    diffview = true
  }
}

-- treesj
local tsj = require('treesj')


tsj.setup({
  use_default_keymaps = false,
})

vim.keymap.set('n', '<Leader>\\', tsj.toggle)

-- inc rename
require("inc_rename").setup()
vim.keymap.set("n", "<Leader>rn", ":IncRename ")

-- toggleterm
require("toggleterm").setup{
  start_in_insert = false
}
vim.keymap.set('n', '<Leader>t', '<CMD>exe v:count1 . "ToggleTerm"<CR>')

-- nvim-tree
require("nvim-tree").setup({
  renderer = {
    icons = {
      show = {
        folder = false
      }
    }
  }
})

vim.keymap.set('n', '<Leader>v',   ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<Leader>fr', ':NvimTreeFindFile<CR>')

--bwap
vim.keymap.set('n', '<Leader>ne', ':NavBuffer<CR>')
vim.keymap.set('n', '<Leader>nn', ':SwapBuffer<CR>')
vim.keymap.set('n', '<Leader>nd', ':DeleteBuffer<CR>')

-- Telescope{
local fzf_opts = {
  fuzzy                   = true,
  override_generic_sorter = true,
  override_file_sorter    = true,
  case_mode               = "smart_case"
}
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-Down>"] = require('telescope.actions').cycle_history_next,
        ["<C-Up>"]   = require('telescope.actions').cycle_history_prev,
        ["<C-j>"]    = require('telescope.actions').move_selection_next,
        ["<C-k>"]    = require('telescope.actions').move_selection_previous,
        ["<C-f>"]    = require('telescope.actions').to_fuzzy_refine,
      },
    },
  },
  extensions = {
    fzf = fzf_opts
  },
  pickers = {
    lsp_dynamic_workspace_symbols = {
      sorter = require('telescope').extensions.fzf.native_fzf_sorter(fzf_opts)
    },
  },
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

vim.keymap.set('n', '<C-t>',        telescope_builtin.find_files)
vim.keymap.set('n', '<C-S-p>',      telescope_builtin.resume)
vim.keymap.set('n', '<Leader>a',    telescope_builtin.grep_string)
vim.keymap.set('n', '<Leader><CR>', telescope_builtin.buffers)
vim.keymap.set('n', '<Leader>ff',   telescope_builtin.live_grep)
vim.keymap.set('n', '<Leader>/',    telescope_builtin.search_history)
vim.keymap.set('n', '<Leader>:',    telescope_builtin.command_history)
vim.keymap.set('n', '<Leader>k',    telescope_builtin.quickfix)
vim.keymap.set('n', '<Leader>j',    telescope_builtin.jumplist)
vim.keymap.set('n', '""',           telescope_builtin.registers)

require'hop'.setup()
vim.keymap.set('n', '<S-a>', '<CMD>HopPattern<CR>',  {silent = true})

-- Portal
require("portal").setup({
})

vim.keymap.set("n", "<Leader>i", "<cmd>Portal jumplist backward<cr>")
vim.keymap.set("n", "<Leader>o", "<cmd>Portal jumplist forward<cr>")

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

-- coq
vim.g.coq_settings = { auto_start = 'shut-up' }

-- gitsigns
require('gitsigns').setup()
