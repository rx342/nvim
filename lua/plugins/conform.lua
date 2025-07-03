return {
  "conform.nvim",
  event = { "BufWritePre" },
  after = function()
    require("conform").setup({
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 5000,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        markdown = { "prettierd" },
        lua = { "stylua" },
        python = { "ruff_organize_imports", "ruff_format" },
        tex = function(bufnr)
          if
            require("conform").get_formatter_info("tex-fmt", bufnr).available
          then
            return { "tex-fmt" }
          else
            return { "latexindent" }
          end
        end,
        bib = function(bufnr)
          if
            require("conform").get_formatter_info("tex-fmt", bufnr).available
          then
            return { "tex-fmt" }
          else
            return { "latexindent" }
          end
        end,
        c = { "clang-format" },
        cpp = { "clang-format" },
        nix = { "nixfmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        just = { "just" },
      },
    })
  end,
}
