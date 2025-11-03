return {
  {
    'mattn/emmet-vim',

    -- NOTE: https://github.com/mattn/emmet-vim/issues/559 が解決するまではバージョン固定しないと動作しない。
    commit = '3fb2f63799e1922f7647ed9ff3b32154031a76ee',
    pin = true,

    init = function()
      vim.g.user_emmet_install_global = 0
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "html", "css", "scss", "typescriptreact" },
        callback = function()
          vim.cmd("EmmetInstall")
          vim.keymap.set("i", "<Tab>", "<Plug>(emmet-expand-abbr)", { buffer = true, silent = true, remap = true, desc = "Emmet expand abbr" })
        end,
      })
    end,
  },
}
