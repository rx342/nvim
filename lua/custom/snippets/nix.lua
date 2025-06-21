return {
  s(
    "drv",
    fmt(
      [[
        stdenv.mkDerivation {
            pname = "<name>";
            src = <src>;
            nativeBuildInputs = [
              <nativePkgs>
            ];
            buildInputs = [
              <buildPkgs>
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
        src = i(1),
        name = f(function(args, _, _)
          local parts = vim.split(args[1][1], ".", { plain = true })
          return parts[#parts] or ""
        end, { 1 }),
        nativePkgs = i(2),
        buildPkgs = i(3),
        build = i(4),
        install = i(5),
      },
      { delimiters = "<>" }
    )
  ),
}
