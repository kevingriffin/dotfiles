local wk = require('which-key')
local sessions = require('mini.sessions')
local telescope_builtin = require 'telescope.builtin'

-- Functions for keymappings --

-- use the path as a session file, but don't put literal slashes into the filename to make it easier to use
local writeSession = function()
  local path = string.gsub(vim.fn.getcwd(), "/", "_")
  sessions.write(path)
end

function getVisualSelection()
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

function searchVisualSelection()
	local text = getVisualSelection()
	telescope_builtin.live_grep({ default_text = text })
end


wk.register(
  {
    a = { telescope_builtin.grep_string, 'Search under cursor' },
    b = {
      name = 'buffer',
      b    = { '<C-^>',         'Move to alternative buffer' },
      d    = { ':Bwipeout<CR>', 'Delete buffer'              }
    },

    c = {':let @+ = expand("%")<CR>', 'Copy filepath to clipboard' },

    d = { '<CMD>TroubleToggle<CR>', 'Trouble'},

    f = { telescope_builtin.live_grep, 'Find string' },

    i = { '<CMD>Portal jumptlist forward', 'Portal forward'},

    j = { telescope_builtin.jumptlist, 'Jumplist' },

    k = { telescope_builtin.quickfix, 'Quickfix' },

    m = {
      name = 'mini',
      s    = { writeSession, 'Write to session' }
    },

    o = { '<CMD>Portal jumptlist backward', 'Portal backward' },

    q = { 'Toggle quickfix' },

    s = { 'Surround' },

    t = { '<CMD>exe v:count1 . "ToggleTerm"<CR>', 'Terminal'},

    v = {
      name = 'tree',
      f  = {':NvimTreeFindFile<CR>', 'File file in tree' },
      v = {'<CMD>NvimTreeToggle<CR>', 'Toggle'},
    },

    w = { '<CMD>WinShift<CR>', 'Shift windows' },

    ['='] = { '<C-W>=', 'Balance windows' },

    ['/'] = { telescope_builtin.search_history, 'Search history' },
    [':'] = { telescope_builtin.command_history, 'Command history' },

    ['<CR>'] = { telescope_builtin.buffers, 'Buffers' }
  }, { prefix = '<Leader>', mode = 'n' }
)

wk.register(
  {
    r = { searchVisualSelection, 'Search visual selection' },
  }, { prefix = '<Leader>', mode = 'v' }
)

wk.register(
  {
    ['""'] = { telescope_builtin.registers, 'Registers' },
    ['<C-t>'] = { telescope_builtin.find_files, 'Find files' },
    ['<C-S-p>'] = { telescope_builtin.resume, 'Resume Telescope' },
  }, { mode = 'n' }
)

wk.register(
  {
    q     = { '<CMD>HopPattern<CR>', 'Jump to pattern' },
    ['?'] = { '<CMD>WhichKey<CR>', 'Help' },
  }, { mode = 'n' }
)

wk.register(
  {
    name = 'Windows',
    ['<C-J>']   = { '<C-W><C-J>', 'Move to window below' },
    ['<C-K>']   = { '<C-W><C-K>', 'Move to window above' },
    ['<C-L>']   = { '<C-W><C-L>', 'Move to window right' },
    ['<C-H>']   = { '<C-W><C-H>', 'Move to window left'  },
    ['<S-A-J>'] = { '<C-W>+',     'Resize up'            },
    ['<S-A-K>'] = { '<C-W>-',     'Resize down'          },
    ['<S-A-L>'] = { '<C-W>>',     'Move to window right' },
    ['<S-A-H>'] = { '<C-W><',     'Move to window left'  },
  }, { mode = 'n' }
)

wk.register(
  {
    name = 'Tab',
    ['<Tab>']   = { '<C-W><C-W>', 'Move to next window'     },
    ['<S-Tab>'] = { '<C-W>W',     'Move to previous window' }
  }, { mode = 'n' }
)

wk.register(
  {
    y = { '"+y', 'Copy to system clipboard' }
  }, { prefix = '<Leader>', mode = 'v' }
)

-- Exit terminal a bit easier
vim.keymap.set('t', '<C-\\><C-\\>', '<C-\\><C-N>')

-- Fix labels
wk.register(
  {
    p = { 'Paste after' },
    ['P'] = { 'Paste before' },
    s = { 'Substitute' },
    ['S'] = { 'which_key_ignore' },
    x = { 'Delete' },
    ['X'] = { 'which_key_ignore' },
    y = { 'Yank' },
    u = { 'Undo' },
    ['Y'] = { 'which_key_ignore' },
    ['<C-N>'] = { 'Multiple cursor mode' },
    ['<C-R>'] = { 'Redo' },
    ['<C-Space>'] = { 'LSP Info' },
    ['<M-p>'] = { 'Yankstack older' },
    ['<M-P>'] = { 'Yankstack newer' },
    ['<M-n>'] = { 'which_key_ignore' },
    ['<2-LeftMouse>'] = { 'which_key_ignore' }
  }
)
