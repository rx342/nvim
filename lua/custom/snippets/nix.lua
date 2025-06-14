require("luasnip.session.snippet_collection").clear_snippets("nix")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local f = ls.function_node

ls.add_snippets("nix", {
  s(
    "drv",
    fmt(
      [[
        stdenv.mkDerivation {
            pname = "<name>";
            src = <src>;
            nativeBuildInputs = [
              <pkgs>
            ];
            buildInputs = [
              <pkgs>
            ];
            buildPhase = ''
              <build>
            '';
            installPhase = ''
              <install>
            '';
        };
      ]],
      {
        src = i(1, "src"),
        name = f(function(args, _, _)
          local parts = vim.split(args[1][1], ".", { plain = true })
          return parts[#parts] or ""
        end, { 1 }),
        pkgs = i(2, "pkgs"),
        build = i(3, "build"),
        install = i(4, "install"),
      },
      { delimiters = "<>" }
    )
  ),
})
