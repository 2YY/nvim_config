-- インデントのデフォルト挙動がおかしいのを直すための設定。
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.cindent = true
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1

-- 上記で直らない部分を以下で個別に調整。
local group = vim.api.nvim_create_augroup("indent", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 2
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
  end,
})

