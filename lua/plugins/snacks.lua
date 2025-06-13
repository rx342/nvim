return {
  "snacks.nvim",
  lazy = false,
  after = function()
    require("snacks").setup({
      styles = {},
      bigfile = { enabled = false },
      notifier = { enabled = false },
      quickfile = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
    })
  end,
  keys = {
    {
      "<leader>gb",
      function()
        Snacks.git.blame_line()
      end,
      desc = "[G]it [B]lame Line",
    },
    {
      "<leader>u",
      function()
        Snacks.picker.undo()
      end,
      desc = "[U]ndo tree",
    },
  },
}
