return {
  "git-conflict.nvim",
  after = function()
    require("git-conflict").setup({
      default_mappings = true,
    })
  end,
}
