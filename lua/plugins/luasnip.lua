return {
  "luasnip",
  before = function()
    require("lz.n").trigger_load("luasnip-snippets")
  end,
  after = function()
    require("luasnip").setup({
      enable_autosnippets = true,
    })
    require("luasnip.loaders.from_lua").load(
      vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)
    )
  end,
  keys = {
    {
      "<C-J>",
      function()
        if require("luasnip").choice_active() then
          require("luasnip").change_choice(1)
        end
      end,
      mode = { "i", "s" },
    },
  },
}
