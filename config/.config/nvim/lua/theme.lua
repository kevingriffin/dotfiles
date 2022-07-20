vim.o.background = "dark"

local c = require("gruvbox-baby.colors").config()

vim.g.gruvbox_baby_highlights = {
  MatchParen = {fg = c.orange, style = "bold" },
  StatusLine = {fg = c.background, style = "bold" },
  Identifier = {fg = c.pink}
}

vim.cmd('colorscheme gruvbox-baby')
