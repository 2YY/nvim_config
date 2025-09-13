require('config.buffer')
require('config.grep')
require('config.lazy')
require('config.line_number')
require('config.lualine')
require('config.mark')
require('config.old_files')
require('config.quickfix')
require('config.window')

require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
})
