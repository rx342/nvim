vim.o.hidden = true
vim.o.encoding = "UTF-8"
vim.o.relativenumber = true
vim.o.number = true
vim.o.autoread = true
vim.o.hlsearch = true
vim.o.backspace = "indent,eol,start"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.opt.breakindent = true
-- Hide tab bar
vim.o.showtabline = 0
vim.o.expandtab = true
vim.o.listchars = "tab:→ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨"
vim.o.list = true
vim.o.ttyfast = true
vim.o.regexpengine = 1
vim.o.timeoutlen = 500
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wildignorecase = true
vim.o.errorbells = false
vim.o.conceallevel = 0
-- Preview substitutions live, as you type!
vim.o.inccommand = "split"
-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"
-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300
-- fish might slow startup
vim.opt.shell = "bash"

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.o.completeopt = "menu,menuone,noselect"
vim.o.laststatus = 3
-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable bold font
vim.g.enable_bold_font = 1

if vim.fn.has("persistent_undo") then
  local path = os.getenv("XDG_CONFIG_HOME") .. "/nvim/undo"
  os.execute("mkdir -p " .. path)
  vim.opt.undofile = true
  vim.opt.undodir = path
end

-- Comments in italic
vim.api.nvim_set_hl(0, "Comment", { italic = true })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup(
    "kickstart-highlight-yank",
    { clear = true }
  ),
  callback = function()
    vim.hl.on_yank()
  end,
})
