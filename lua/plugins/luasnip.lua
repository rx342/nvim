return {
  "luasnip",
  after = function()
    require("luasnip").setup({
      enable_autosnippets = true,
    })
    require("luasnip.loaders.from_lua").load({
      paths = mnw.configDir .. "/pack/mnw/start/source/lua/custom/snippets",
    })
    require("luasnip_snippets.common.snip_utils").setup()
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
