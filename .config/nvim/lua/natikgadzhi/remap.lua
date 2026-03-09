vim.g.mapleader = " "

-- Move chunks of code with automatic indentation
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines, keep cursor position" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Jump half a screen down or up, keeping cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down, center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up, center cursor" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result, center cursor" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result, center cursor" })

-- Paste without overwriting the yank register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable ex mode" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer" })

-- Navigate quickfix and location lists
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Prev quickfix item" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location list item" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Prev location list item" })
