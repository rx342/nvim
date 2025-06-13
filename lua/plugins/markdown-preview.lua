return {
  "markdown-preview.nvim",
  after = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_browser = "zen"
  end,
}
