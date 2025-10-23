-- NOTE: `ensure_installed` と最下部の `vim.lsp.config` に、必要なものを適宜追加。

return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "vtsls" },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, silent = true, noremap = true }
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { silent = true })
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

        vim.keymap.set("n", "<leader>lR", function()
          vim.lsp.buf.references({ includeDeclaration = false }, {
            on_list = function(opts)
              vim.fn.setqflist({}, " ", opts)
              vim.cmd.copen()
              vim.cmd.wincmd("p")
            end,
          })
        end, o)
      end

      vim.lsp.config("lua_ls",   { on_attach = on_attach })
      vim.lsp.config("vtsls",    { on_attach = on_attach })
    end,
  },
}

