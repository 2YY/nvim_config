-- NOTE: 行番号の表示切替
vim.keymap.set("n", "<Space>un", function()
  local n, rn = vim.wo.number, vim.wo.relativenumber
  if n and rn then
    vim.wo.number = true
    vim.wo.relativenumber = false
    vim.notify("行番号: 絶対表示", vim.log.levels.WARN)
  elseif n and not rn then
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.notify("行番号: 非表示", vim.log.levels.WARN)
  else
    vim.wo.number = true
    vim.wo.relativenumber = true
    vim.notify("行番号: 相対表示", vim.log.levels.WARN)
  end
end, { desc = "行番号表示の切替" })

-- NOTE: デフォルトでは行番号は、現在行からの相対表示にしておく。
vim.opt.number = true
vim.opt.relativenumber = true
