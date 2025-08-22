return {
  "nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  after = function()
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      float = {
        border = "rounded",
        format = function(diagnostic)
          return string.format(
            "%s (%s) [%s]",
            diagnostic.message,
            diagnostic.source,
            diagnostic.code or diagnostic.user_data.lsp.code
          )
        end,
      },
    })

    local signs =
      { Error = " ", Warn = " ", Hint = " ", Info = " " }

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("rx-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(
            mode,
            keys,
            func,
            { buffer = event.buf, desc = "LSP: " .. desc }
          )
        end

        map("K", vim.lsp.buf.hover, "doc")
        map("gd", vim.lsp.buf.definition, "go to def")
        map("grr", function()
          require("fzf-lua").lsp_references()
        end, "go to ref")
        map("gri", function()
          require("fzf-lua").lsp_implementations()
        end, "go to implem")
        map("gra", function()
          require("fzf-lua").lsp_code_actions()
        end, "action")

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if
          client
          and client.supports_method(
            vim.lsp.protocol.Methods.textDocument_documentHighlight
          )
        then
          local highlight_augroup =
            vim.api.nvim_create_augroup("rx-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup(
              "rx-lsp-detach",
              { clear = true }
            ),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({
                group = "rx-lsp-highlight",
                buffer = event2.buf,
              })
            end,
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if
          client
          and client.supports_method(
            vim.lsp.protocol.Methods.textDocument_inlayHint
          )
        then
          Snacks.toggle.inlay_hints():map("<leader>ci")
        end
      end,
    })

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    Snacks.toggle.diagnostics():map("<leader>cd")

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      require("blink.cmp").get_lsp_capabilities()
    )

    -- NOTE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

    require("lspconfig").basedpyright.setup({
      settings = {
        basedpyright = {
          typeCheckingMode = "standard",
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            ignore = { "*" },
          },
        },
      },
      capabilities = capabilities,
    })

    require("lspconfig").ruff.setup({
      capabilities = capabilities,
    })

    -- NOTE: `bashls` automatically uses `shellcheck` if available
    require("lspconfig").bashls.setup({
      cmd = {
        "bash-language-server",
        "start",
      },
      capabilities = capabilities,
    })

    require("lspconfig").clangd.setup({
      capabilities = capabilities,
    })

    require("lspconfig").lua_ls.setup({
      cmd = { "lua-language-server" },
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if
          vim.uv.fs_stat(path .. "/.luarc.json")
          or vim.uv.fs_stat(path .. "/.luarc.jsonc")
        then
          return
        end

        client.config.settings.Lua =
          vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
          })
      end,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          telemetry = {
            enable = false,
          },
        },
      },
      capabilities = capabilities,
    })

    require("lspconfig").nixd.setup({
      cmd = { "nixd" },
      capabilities = capabilities,
    })

    require("lspconfig").texlab.setup({
      settings = {
        texlab = {
          latexFormatter = "none",
          bibtexFormatter = "none",
        },
      },
      capabilities = capabilities,
    })

    require("lspconfig").marksman.setup({ capabilities = capabilities })

    require("lspconfig").nushell.setup({ capabilities = capabilities })

    require("lspconfig").astro.setup({ capabilities = capabilities })

    require("lspconfig").ts_ls.setup({ capabilities = capabilities })

    require("lspconfig").hls.setup({ capabilities = capabilities })
  end,
  keys = {
    {
      "<C-n>",
      "<cmd>lua vim.diagnostic.goto_next()<cr>",
      desc = "lsp next",
    },
    {
      "<C-p>",
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      desc = "lsp prev",
    },
    {
      "<leader>ch",
      "<cmd>lua vim.diagnostic.open_float()<CR>",
      desc = "[C]ode [H]over Diagnostic",
    },
  },
}
