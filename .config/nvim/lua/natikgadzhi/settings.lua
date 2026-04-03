-- Settings go here

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undodir"
vim.fn.mkdir(vim.fn.stdpath("state") .. "/undodir", "p")
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250

vim.opt.clipboard = "unnamedplus"

-- Colored vertical bar at the given column. Empty string disables it.
vim.opt.colorcolumn = ""

-- Hide tmux status bar when nvim is active (lualine replaces it).
-- Tmux hooks in tmux.conf handle the case when switching between windows/panes.
if vim.env.TMUX then
  vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
    callback = function()
      vim.fn.system("tmux set status off")
    end,
  })
  vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
    callback = function()
      vim.fn.system("tmux set status on")
    end,
  })
end
