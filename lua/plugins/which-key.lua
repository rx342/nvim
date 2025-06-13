return {
  "which-key.nvim",
  event = "DeferredUIEnter",
  after = function()
    require("which-key").setup({
      preset = "modern",
      win = {
        border = "single",
      },
      spec = {
        {
          "<leader>p",
          "<cmd>buffer #<cr>",
          desc = "Switch [P]revious Vuffer",
        },
        {
          "<leader>r",
          "<cmd>source %<cr>",
          desc = "Source cu[R]rent",
        },
        {
          "<leader>x",
          "<cmd>lua vim.fn.system('chmod +x ' .. vim.fn.expand('%')) vim.notify(\"File made executable!\")<cr>",
          desc = "Make e[X]ecutable",
        },
        {
          "<M-f>",
          '<cmd>silent !tmux neww "fish -c fish_tmux_sessionizer"<cr>',
          desc = "tmux sessionizer",
        },
        {
          "<M-y>",
          '<cmd>silent !tmux neww "fish -c fish_tmux_tmp_dir"<cr>',
          desc = "tmux tmp dir",
        },
        {
          "<C-j>",
          "<cmd>cnext<cr>",
          desc = "quickfix next",
        },
        {
          "<C-k>",
          "<cmd>cprev<cr>",
          desc = "quickfix prev",
        },
        {
          "<C-q>",
          "<cmd>cclose<cr>",
          desc = "quickfix close",
        },
      },
    })
  end,
}
