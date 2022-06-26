vim.o.background = "dark"
-- require('material.functions').change_style("darker")
vim.g.material_style = "darker"
-- vim.cmd('colorscheme material')
local c = require("gruvbox-baby.colors").config()
vim.g.gruvbox_baby_highlights = {
  MatchParen = {fg = c.orange, style = "bold,underline" },
  StatusLine = {fg = c.background, style = "bold" },
  Identifier = {fg = c.pink}
  -- StatusLineNC = {fg = c.background, style = "bold" }
}
vim.cmd('colorscheme gruvbox-baby')
