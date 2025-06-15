{
  pkgs,
  mnw,
  lib,
}:

mnw.lib.wrap pkgs {
  neovim = pkgs.neovim-unwrapped;
  aliases = [
    "vi"
    "vim"
  ];
  appName = "nvim-rx";
  desktopEntry = false;
  providers = {
    python3.enable = true;
    nodeJs.enable = true;
  };
  extraLuaPackages =
    ps: with ps; [
      magick
      jsregexp
    ];
  extraBinPath = with pkgs; [
    fzf
    fd
    ripgrep
    bat
    shellcheck
    basedpyright
    nodePackages.bash-language-server
    prettierd
    neovim-remote
    lua-language-server
    nixd
    nixfmt-rfc-style
    ruff
    shfmt
    stylua
    marksman
    yarn # markdown-preview
  ];
  plugins = {
    start =
      (with pkgs.vimPlugins; [
        blink-cmp
        (nvim-treesitter.withPlugins (
          p: with p; [
            tree-sitter-nix
            tree-sitter-python
            tree-sitter-bash
            tree-sitter-lua
            tree-sitter-vim
            tree-sitter-just
            tree-sitter-yaml
            tree-sitter-markdown
            tree-sitter-markdown-inline
            tree-sitter-html
            tree-sitter-cpp
            tree-sitter-fish
            tree-sitter-nu
          ]
        ))
      ])
      ++ mnw.lib.npinsToPlugins pkgs ./start.json;
    opt =
      (with pkgs.vimPlugins; [
        markdown-preview-nvim
      ])
      ++ mnw.lib.npinsToPlugins pkgs ./opt.json;
    dev.rx = {
      pure = lib.fileset.toSource {
        root = ./..;
        fileset = lib.fileset.unions [
          ../lua
          ../after
        ];
      };
    };
  };
  initLua = # lua
    ''
      require("rx")
      require("lz.n").load("plugins")
      require("rx.colors")
    '';
}
