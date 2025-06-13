return {
  "nvim-treesitter",
  after = function()
    require("nvim-treesitter.configs").setup({
      modules = {},
      sync_install = false,
      ignore_install = {},
      ensure_installed = {},
      auto_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}
