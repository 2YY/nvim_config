-- NOTE: マークをQuickfixで表示
local function is_abs_or_home(path_str)
  return path_str:match("^/")        -- Unix 絶対
      or path_str:match("^~[/\\]")   -- ~/
      or path_str:match("^%a:[/\\]") -- C:/ or C:\
      or path_str:match("^\\\\")     -- UNC: \\server\share
end

local function is_user_mark(m)
  return m ~= nil and m:match("^[A-Za-z]$") ~= nil
end

local function marks()
  local out = vim.api.nvim_command_output("marks")
  local qflist = {}

  for line in out:gmatch("[^\n]+") do
    local mark, lnum, col, rest = line:match("^%s*(%S)%s+(%d+)%s+(%d+)%s+(.*)$")
    if mark and tonumber(lnum) ~= 0 and is_user_mark(mark) then -- NOTE: 位置が失われた無効なマークと自動で作成されるマークは除外してます。
      local filename = is_abs_or_home(rest) and rest or vim.fn.expand("%:p")
      table.insert(qflist, {
        filename = filename,
        lnum = tonumber(lnum),
        col = tonumber(col),
        text = string.format("%s: %s", mark, rest),
      })
    end
  end

  if #qflist == 0 then
    vim.notify("ユーザー定義のマークは見つかりませんでした。", vim.log.levels.WARN)
  else
    vim.fn.setqflist(qflist, "r")
    vim.cmd("copen")
  end
end

vim.keymap.set("n", "<leader>`", marks, { silent = true, desc = "マークの一覧をQuickfixで開く" })
