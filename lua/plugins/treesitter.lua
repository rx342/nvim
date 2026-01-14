return {
  "nvim-treesitter",
  after = function()
    require("nvim-treesitter").setup()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "nix",
        "python",
        "bash",
        "lua",
        "vim",
        "just",
        "yaml",
        "markdown",
        "html",
        "cpp",
        "fish",
        "nu",
        "haskell",
      },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
