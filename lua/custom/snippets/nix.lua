require("luasnip.session.snippet_collection").clear_snippets("nix")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local f = ls.function_node

ls.add_snippets("nix", {
  s(
    "pkgs",
    fmt([[{pkgs} = {nixpkgs}.legacyPackages.{system};]], {
      pkgs = i(1, "pkgs"),
      nixpkgs = i(2, "nixpkgs"),
      system = i(3, "${pkgs.system}"),
    })
  ),
  s(
    "deriv",
    fmt(
      [[
        <name>-drv = pkgs.stdenv.mkDerivation {
            name = "<name>";
            src = <src>;
            nativeBuildInputs = with pkgs; [
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
