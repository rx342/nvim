return {
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
}
