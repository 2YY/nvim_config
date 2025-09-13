-- NOTE: 最近開いたファイルのリストをQuickfixで表示
local function browse_old_files()
  local function norm(p) return vim.fn.fnamemodify(p, ":p"):gsub("\\", "/") end

  local cwd = norm(vim.loop.cwd() or vim.fn.getcwd())

  if not cwd:match("/$") then cwd = cwd .. "/" end

  local items, seen = {}, {}
  for _, f in ipairs(vim.v.oldfiles) do
    local p = norm(f)
    if p:sub(1, #cwd) == cwd and vim.fn.filereadable(p) == 1 and not seen[p] then
      table.insert(items, {
        filename = p, lnum = 1, col = 1,
        text = vim.fn.fnamemodify(p, ":."),
      })
      seen[p] = true
    end
  end

  if #items == 0 then
    vim.notify("最近開いたファイルは見つかりませんでした。", vim.log.levels.WARN)
  else
    vim.fn.setqflist(items, "r")
    vim.cmd("copen")
  end
end

vim.keymap.set("n", "<leader>fo", browse_old_files, { silent = true, desc = "最近開いたファイルをQuickfixで表示" })
