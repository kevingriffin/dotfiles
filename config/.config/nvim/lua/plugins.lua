require('lazy').setup({
'echasnovski/mini.nvim',                        -- many helpful plugings: sessions, starter, trailspace, align, comment, bracketed, surround
'nvim-treesitter/nvim-treesitter',              -- treesitter configurations for syntax highlighting and more
'nvim-treesitter/nvim-treesitter-textobjects',  -- add textobjects with treesitter
'RRethy/nvim-treesitter-endwise',               -- automatically add end in Ruby
'nvim-treesitter/playground',                   -- visualize lsp nodes
'phaazon/hop.nvim',                             -- quick navigation to matching string
'terryma/vim-multiple-cursors',                 -- multiple cursors
'maxbrunsfeld/vim-yankstack',                   -- cycle through yanked items when pasting
'mbbill/undotree',                              -- view a tree of undos and step back and forward
'ojroques/vim-oscyank',                         -- yank using osc52, to send to clipboard on remote clients
'andymass/vim-matchup',                         -- highlight the start and end of blocks
'windwp/nvim-autopairs',                        -- auto pair punctuation
'windwp/nvim-ts-autotag',                       -- auto pair and rename TSX tags
'smjonas/inc-rename.nvim',                      -- interactively rename LSP objects
'Wansmer/treesj',                               -- split/join lines based on treesitter
'nvim-telescope/telescope.nvim',                -- a fuzzy finder
'kyoh86/telescope-windows.nvim',                -- add a list of neovim windows to telescope
'nvim-lua/plenary.nvim',                        -- required by many other plugins
'moll/vim-bbye',                                -- close buffers without closing the window they're in
'sindrets/winshift.nvim',                       -- interactively rearrange windows
'Valloric/ListToggle',                          -- keybindings to toggle the quickfix list and locationlist
'kyazdani42/nvim-tree.lua',                     -- a sidebar file explorer tree
'kevinhwang91/nvim-bqf',                        -- adds a preview to the currently selected quickfix item
'cbochs/portal.nvim',                           -- locationlists with previews and multiple stacks
'lewis6991/gitsigns.nvim',                      -- view git changes in sidebar
'sindrets/diffview.nvim',                       -- a tabpage for viewing the diffs in a git revision
'luisiacc/gruvbox-baby',                        -- a treesitter-aware theme
'nvim-lualine/lualine.nvim',                    -- statusline
'neovim/nvim-lspconfig',                        -- configurations for the LSP client in neovim
'nvim-lua/lsp-status.nvim',                     -- statusline components from LSP, like current function
'kyazdani42/nvim-web-devicons',                 -- icons for use with plugins like nvim-tree
'folke/trouble.nvim',                           -- a status pane containing diagnostic information from LSP
'jose-elias-alvarez/null-ls.nvim',              -- allows plugging into LSP from non-server plugins, like gitsigns
'jose-elias-alvarez/typescript.nvim',           -- adds typescript commands to LSP's code actions
'akinsho/toggleterm.nvim',                      -- toggleable, persistent terminals for running tests and other tasks
'yorickpeterse/nvim-dd',                        -- defer diagnostics, needed to make trouble and coq work together well
-- this fix should no longer be needed, but seems to be for me as of 0.9:
-- https://github.com/neovim/neovim/pull/20198
'antoinemadec/FixCursorHold.nvim',
{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, -- faster and fuzzy sorting for telescope
{ 'ms-jpq/coq_nvim', lazy = false, init = function() vim.g.coq_settings = { auto_start = 'shut-up' } end }, -- autocomplete
{
  "folke/which-key.nvim", -- organize and preview keymappings
  config = function()
    require("which-key").setup({
      presets = {
        operators = false, -- adds help for operators like d, y, ...
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false, -- default bindings on <c-w>
        nav = false,
      }
    })
  end,
},
})

-- mini.nvim --

require('mini.align').setup()
require('mini.comment').setup()

local sessions = require('mini.sessions')
sessions.setup({
  autoread  = false,
  autowrite = false,
  directory = '~/.local/share/nvim/sessions',
  force = { read = false, write = true, delete = false }
})

require('mini.trailspace').setup({})

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*' },
    callback = function()
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
    end
})

require('mini.bracketed').setup()

require('mini.surround').setup({
    mappings = {
    add = '<Leader>sa', -- Add surrounding in Normal and Visual modes
    delete = '<Leader>sd', -- Delete surrounding
    find = '<Leader>sf', -- Find surrounding (to the right)
    find_left = '<Leader>sF', -- Find surrounding (to the left)
    highlight = '<Leader>sh', -- Highlight surrounding
    replace = '<Leader>sr', -- Replace surrounding
    update_n_lines = '<Leader>sn', -- Update `n_lines`

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'n', -- Suffix to search with "next" method
  },
})


-- nvim-treesitter --

-- Necessary to build some grammars if clang is installed via nix
require('nvim-treesitter.install').compilers = { 'clang++' }

require('nvim-treesitter.configs').setup {
  autotag = {
    enable = true
  },
  endwise = {
    enable = true,
  },
  ensure_installed = 'all',
  highlight = {
    enable                            = true,
    disable                           = { },
    additional_vim_regex_highlighting = false,
  },
  ignore_install = { 'phpdoc' }, -- broken
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection    = ';v',
      node_incremental  = 'ni',
      scope_incremental = 'si',
      node_decremental  = 'nd',
    },
  },
  indent = {
    enable  = true,
    disable = {},
  },
  matchup = {
    enable  = true,
    disable = {},
  },
  -- install one-at-a-time on low-memory servers
  sync_install = (vim.loop.os_uname().sysname == 'Linux' and true or false),
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        [';>'] = '@parameter.inner',
      },
      swap_previous = {
        [';<'] = '@parameter.inner',
      },
    },
    select = {
      enable    = true,
      lookahead = true,
      keymaps   = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
  }
}

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }


-- hop.nvim --
require('hop').setup()

-- vim-multiple-cursors --
-- Stay in multiple cursor mode until canceled, for better movement
vim.g.multi_cursor_exit_from_insert_mode = 0


-- vim-matchup --
vim.g.matchup_matchparen_offscreen = { scrolloff = 1 }


-- nvim-autopairs --
local npairs = require('nvim-autopairs')
local remap = vim.api.nvim_set_keymap

npairs.setup {
  map_cr                    = false,
  map_bs                    = false,
  enable_check_bracket_line = false
}

-- Remap CR and BS to work with autopairs. Specifically, this allows indent to keep working
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


-- inc rename --
require("inc_rename").setup()

-- treesj --
local tsj = require('treesj')
tsj.setup({
  use_default_keymaps = false,
})

vim.keymap.set('n', '<Leader>\\', tsj.toggle)


-- telescope.nvim --
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

-- winshift.nvim --
require("winshift").setup()

-- nvim-tree.lua --
require("nvim-tree").setup({
  renderer = {
    icons = {
      show = {
        folder = false
      }
    }
  }
})

-- portal.nvim --
require("portal").setup({})


-- gitsigns.nvim --
require('gitsigns').setup()


-- lualine.nvim --
local lsp_status = require('lsp-status')

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

-- trouble.nvim --
require("trouble").setup {}

-- toggleterm.nvim --
require("toggleterm").setup{
  start_in_insert = false
}

-- nvim-dd --

-- Load diagnostics instantly in normal mode but not in insert mode, to avoid trouble.nvim breaking coq_nvim
require('dd').setup({
  timeout = 0
})

-- coq_vim --
vim.g.coq_settings = {
  clients = {
    snippets = {
      warn = {}
    }
  },
  display = {
    pum = {
      y_ratio   = 0.4,
      x_max_len = 88
    },
    preview = {
      x_max_len = 160
    }
  },
-- Don't overrwrite my binds for moving between splits
  keymap = {
    recommended = false,
    jump_to_mark = ''
  }
}
