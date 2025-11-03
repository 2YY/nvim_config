-- NOTE: ウィンドウのフォーカス移動
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "ウィンドウのフォーカスを左に"})
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "ウィンドウのフォーカスを下に"})
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "ウィンドウのフォーカスを上に"})
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "ウィンドウのフォーカスを右に"})
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "ウィンドウのフォーカスを左に"})
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "ウィンドウのフォーカスを下に"})
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "ウィンドウのフォーカスを上に"})
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "ウィンドウのフォーカスを右に"})

-- NOTE: ウィンドウのサイズ調整
vim.keymap.set("n", "<C-Up>",   "<Cmd>execute 'normal! ' .. v:count1 .. '<C-w>+'<CR>", { silent = true, desc = "ウィンドウの高さを広げる" })
vim.keymap.set("n", "<C-Down>","<Cmd>execute 'normal! ' .. v:count1 .. '<C-w>-'<CR>", { silent = true, desc = "ウィンドウの高さを狭める" })
vim.keymap.set("n", "<C-Right>",   "<Cmd>execute 'normal! ' .. v:count1 .. '<C-w>>'<CR>", { silent = true, desc = "ウィンドウの幅を広げる" })
vim.keymap.set("n", "<C-Left>",   "<Cmd>execute 'normal! ' .. v:count1 .. '<C-w><'<CR>", { silent = true, desc = "ウィンドウの幅を狭める" })

-- NOTE: ウィンドウの分割
vim.keymap.set("n", "|", "<Cmd>vsplit<CR>",  { noremap = true, silent = true, desc = "ウィンドウを左右に分割" })
vim.keymap.set("n", "<Bslash>", "<Cmd>split<CR>", { noremap = true, silent = true, desc = "ウィンドウを上下に分割" })
