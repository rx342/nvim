return {
  "neogit",
  after = function()
    require("neogit").setup({
      disable_commit_confirmation = true,
      integrations = {
        fzf_lua = true,
      },
      graph_style = "unicode",
    })
  end,
  keys = {
    { "<leader>gn", "<cmd>Neogit<cr>", desc = "[G]it [N]vim" },
  },
}
