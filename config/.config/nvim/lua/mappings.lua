local wk = require('which-key')
local sessions = require('mini.sessions')

-- Functions for keymappings --

-- use the path as a session file, but don't put literal slashes into the filename to make it easier to use
local writeSession = function()
  path = string.gsub(vim.fn.getcwd(), "/", "_")
  sessions.write(path)
end

wk.register(
  {
    b = {
      name = 'buffer',
      b    = { '<C-^>',         'Move to alternative buffer' },
      d    = { ':Bwipeout<CR>', 'Delete buffer'              }
    },

    ['cf'] = {':let @+ = expand("%")<CR>', 'Copy filepath to clipboard' },

    m = {
      name = 'mini',
      s    = { writeSession, 'Write to session' }
    },

    ['='] = { '<C-W>=', 'Balance windows' }
  }, { prefix = '<Leader>', mode = 'n' }
)

wk.register(
  {
    name = 'Hop',
    q    = { '<CMD>HopPattern<CR>', 'Jump to pattern' },
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
