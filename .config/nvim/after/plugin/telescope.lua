-- Telescope is now configured inline in lazy.lua
-- This file just sets up the keymaps

local ok, builtin = pcall(require, "telescope.builtin")
if not ok then
    return
end

vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git files" })
vim.keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Grep string" })
