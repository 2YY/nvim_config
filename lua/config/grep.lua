-- NOTE: grep で rg を使う。
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"

-- NOTE: grep で検索ワード以外をデフォルト入力。
vim.keymap.set("n", "<leader>fw", ":silent grep!  <Bar> copen<Left><Left><Left><Left><Left><Left><Left><Left>", { desc = "grep (プロジェクト全体)" })
vim.keymap.set("n", "<leader>fW", ":silent grep!  % <Bar> copen<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>", { desc = "grep (現在のファイル)" })
