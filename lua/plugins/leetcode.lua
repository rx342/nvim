return {
  "leetcode",
  after = function()
    require("leetcode").setup({
      lang = "python3",
      plugins = {
        non_standalone = true,
      },
      picker = "fzf-lua",
      storage = {
        home = vim.fn.getenv("HOME") .. "/work/lc",
      },
    })
  end,
  keys = {
    {
      "<leader>l",
      "<cmd>Leet list<cr>",
      mode = "n",
    },
    {
      "<leader>t",
      "<cmd>Leet test<cr>",
      mode = "n",
    },
    {
      "<leader>s",
      "<cmd>Leet submit<cr>",
      mode = "n",
    },
    {
      "<leader>h",
      "<cmd>Leet info<cr>",
      mode = "n",
    },
    {
      "<leader>q",
      "<cmd>Leet desc<cr>",
      mode = "n",
    },
  },
}
