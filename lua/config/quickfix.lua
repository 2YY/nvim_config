-- NOTE: q を押すだけで閉じる。
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true, noremap = true }
    vim.keymap.set("n", "q", "<Cmd>close<CR>", opts)
  end,
})
