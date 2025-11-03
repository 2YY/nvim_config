-- NOTE: 現在のバッファを閉じる。
vim.g.mapleader = ' '
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { silent = true })

-- NOTE: バッファの管理UIを開く
vim.keymap.set("n", "<leader>b", "<Cmd>JABSOpen<CR>", { noremap = true, silent = true, desc = "Open JABS" })
