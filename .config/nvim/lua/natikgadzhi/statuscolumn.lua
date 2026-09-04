-- Gutter layout: one cell of sign, the line number, one cell of padding in the
-- editor background colour. The stock sign column is always two cells wide even
-- though gitsigns and the diagnostic signs only ever draw one character, so the
-- signs are rendered here instead and 'signcolumn' is turned off.
--
-- 'numberwidth' pins the total width of a custom 'statuscolumn' -- it does not
-- grow to fit the content the way the built-in number column does -- so the
-- width is tracked to the buffer's digit count instead of left at the default.

local M = {}

-- First sign on the line, trimmed to a single cell, carrying its own highlight.
-- Signs live as extmarks since 0.10, which covers gitsigns and the legacy
-- :sign API both.
function M.sign()
  local lnum = vim.v.lnum - 1
  local marks = vim.api.nvim_buf_get_extmarks(
    0, -1, { lnum, 0 }, { lnum, -1 }, { type = "sign", details = true })

  for _, mark in ipairs(marks) do
    local details = mark[4]
    if details.sign_text then
      local char = vim.fn.strcharpart(vim.trim(details.sign_text), 0, 1)
      if char ~= "" then
        return "%#" .. (details.sign_hl_group or "SignColumn") .. "#" .. char
      end
    end
  end

  return " "
end

function M.set_width()
  local digits = #tostring(math.max(vim.api.nvim_buf_line_count(0), 1))
  -- sign + number + padding, and never narrower than a three digit number.
  vim.wo.numberwidth = math.max(digits, 3) + 2
end

function M.setup()
  vim.opt.signcolumn = "no"
  vim.opt.statuscolumn = table.concat({
    "%{%v:lua.require'natikgadzhi.statuscolumn'.sign()%}",
    "%#LineNr#%=",
    "%{v:relnum == 0 ? v:lnum : v:relnum}",
    "%#Normal# ",
  })

  vim.api.nvim_create_autocmd({ "BufWinEnter", "TextChanged" }, {
    group = vim.api.nvim_create_augroup("natikgadzhi_statuscolumn", {}),
    callback = M.set_width,
  })
end

return M
