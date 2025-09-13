return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = function()
      local fish = vim.fn.exepath("fish")
      return {
        shell = (fish ~= "" and fish) or vim.o.shell,
      }
    end,
    keys = {
      { "<Esc>", [[<C-\><C-n>]], mode = "t", silent = true, desc = "Terminal: exit to normal" },
      {
        "<leader>tv",
        function()
          local id   = vim.v.count1
          local size = math.floor(vim.o.columns * 0.35)
          vim.cmd(("%dToggleTerm direction=vertical size=%d"):format(id, size))
        end,
        desc = "ターミナルを表示 (垂直分割)",
        mode = "n",
      },
      {
      "<leader>th",
        function()
          local id   = vim.v.count1
          local size = math.floor(vim.o.lines * 0.30)
          vim.cmd(("%dToggleTerm direction=horizontal size=%d"):format(id, size))
        end,
        desc = "ターミナルを表示 (水平分割)",
        mode = "n",
      },
      {
        "<leader>tt",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local id = vim.v.count1
          Terminal:new({
            direction = "float",
            float_opts = { border = "single" },
            count = id
          }):toggle()
        end,
        desc = "ターミナルを表示 (フロート)",
        mode = { "n", "t" },
      },
    },
  }
}
