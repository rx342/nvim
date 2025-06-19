return {
  "snacks.nvim",
  lazy = false,
  priority = 1000,
  after = function()
    require("snacks").setup({
      styles = {},
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = false },
      input = { enabled = false },
      notifier = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
      picker = { enabled = true },
      git = { enabled = true },
      toggle = { enabled = true },
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
