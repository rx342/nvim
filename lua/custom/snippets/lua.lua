require("luasnip.session.snippet_collection").clear_snippets("lua")

local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets("lua", {
  s(
    "req",
    fmt(
      [[
        local {var} = require("{module}")
      ]],
      {
        module = i(1),
        var = f(function(args, _, _)
          local parts = vim.split(args[1][1], ".", { plain = true })
          return parts[#parts] or ""
        end, { 1 }),
      }
    )
  ),
})
