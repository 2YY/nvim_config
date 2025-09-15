-- NOTE: LazygitでEsc押した時の挙動を壊さないようにしつつ、ターミナルでEsc押すとNormalモード切替できるようにする。
local aug = vim.api.nvim_create_augroup('TermEscFix', { clear = true })
vim.api.nvim_create_autocmd('TermOpen', {
  group = aug,
  pattern = 'term://*',
  callback = function(ev)
    pcall(vim.keymap.del, 't', '<Esc>', { buffer = ev.buf })
    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]],
      { buffer = ev.buf, silent = true, desc = 'Normalモードに切替' })
  end,
})
vim.api.nvim_create_autocmd({ 'TermOpen', 'BufEnter' }, {
  group = aug,
  pattern = 'term://*lazygit*',
  callback = function(ev)
    vim.keymap.set('t', '<Esc>', '<Esc>',
      { buffer = ev.buf, silent = true, noremap = true })
  end,
})

