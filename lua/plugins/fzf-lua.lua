return {
  "fzf-lua",
  event = "VimEnter",
  after = function()
    require("fzf-lua").setup({
      fzf_colors = true,
      defaults = {
        file_icons = "mini",
      },
      winopts = {
        preview = {
          layout = "vertical",
        },
      },
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        },
      },
    })
  end,
  keys = {
    {
      "<leader>ff",
      "<cmd>FzfLua files<cr>",
      desc = "[F]ZF [F]iles",
    },
    {
      "<leader>fg",
      "<cmd>FzfLua git_files<cr>",
      desc = "[F]ZF [G]it Files",
    },
    {
      "<leader>fb",
      "<cmd>FzfLua buffers<cr>",
      desc = "[F]ZF [B]uffers",
    },
    {
      "<leader>fr",
      "<cmd>FzfLua live_grep_glob<cr>",
      desc = "[F]ZF [R]ipgrep",
    },
    {
      "<leader>fh",
      "<cmd>FzfLua helptags<cr>",
      desc = "[F]ZF [H]elp",
    },
    {
      "q:",
      "<cmd>FzfLua command_history<cr>",
      desc = "command history",
    },
    {
      "q/",
      "<cmd>FzfLua search_history<cr>",
      desc = "search history",
    },
  },
}
