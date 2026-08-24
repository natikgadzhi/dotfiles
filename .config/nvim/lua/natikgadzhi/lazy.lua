-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
require("lazy").setup({
  -- Surround quotes and brackets manipulation
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  -- Auto-close brackets, quotes, etc.
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },

-- Telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>pf", function() require("telescope.builtin").find_files() end,                                      desc = "Find files" },
      { "<C-p>",      function()
          local builtin = require("telescope.builtin")
          local dir = vim.b.netrw_curdir
            or (vim.bo.buftype == "" and vim.fn.expand("%:p:h"))
            or vim.fn.getcwd()
          local git_root = vim.fs.root(dir, ".git")
          if git_root then
            builtin.git_files({ cwd = git_root })
          else
            builtin.find_files({ cwd = dir })
          end
        end, desc = "Git files (smart: buffer dir → git root, else find_files)" },
      { "<leader>pg", function() require("telescope.builtin").live_grep() end,                                       desc = "Live grep" },
      { "<leader>pb", function() require("telescope.builtin").buffers() end,                                         desc = "Buffers" },
      { "<leader>ps", function() require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") }) end, desc = "Grep string" },
    },
  },

  -- Dracula, matching opencode's `dracula` theme (set in the TUI, persisted
  -- in ~/.local/state/opencode/kv.json) and Ghostty (theme = Dracula): full
  -- #282a36 background, purple #bd93f9 accents. mini.base16 generates the
  -- full highlight set — treesitter, LSP, telescope, gitsigns, lualine —
  -- from these 16 colours, so the palette is the only thing to maintain.
  --
  -- Syntax colours are the official Dracula palette (keywords/numbers purple,
  -- functions green, strings yellow, types cyan, operators pink); base04 is
  -- the one invention: Dracula has no step between the comment blue-grey and
  -- the foreground, so it is interpolated.
  {
    "echasnovski/mini.base16",
    lazy = false,
    priority = 1000,
    config = function()
      require("mini.base16").setup({
        palette = {
          base00 = "#282a36", -- background          (Dracula background)
          base01 = "#21222c", -- panel / status bar background (Dracula darker bg)
          base02 = "#44475a", -- selection background (Dracula current line)
          base03 = "#6272a4", -- comments, invisibles (Dracula comment)
          base04 = "#adb5cb", -- muted text (interpolated: comment → foreground)
          base05 = "#f8f8f2", -- default foreground  (Dracula foreground)
          base06 = "#fbfbfa", -- light foreground (interpolated)
          base07 = "#ffffff", -- lightest foreground
          base08 = "#ff5555", -- variables, errors   (Dracula red)
          base09 = "#bd93f9", -- constants, numbers  (Dracula purple)
          base0A = "#8be9fd", -- classes, search     (Dracula cyan)
          base0B = "#f1fa8c", -- strings             (Dracula yellow)
          base0C = "#ff79c6", -- escapes, operators  (Dracula pink)
          base0D = "#50fa7b", -- functions           (Dracula green)
          base0E = "#bd93f9", -- keywords            (Dracula purple)
          base0F = "#ffb86c", -- special             (Dracula orange)
        },
        use_cterm = true,
      })
      -- mini.base16 applies highlights directly and leaves colors_name unset;
      -- name it so :colorscheme and plugins that sniff it have an answer.
      vim.g.colors_name = "dracula"
    end,
  },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "typescript", "swift" },
        sync_install = false,
        auto_install = true,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = {
      throttle = true,
      max_lines = 10000,
    },
  },

  -- Undotree
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
    },
  },

  -- Diff viewer for git diffs and merge conflicts
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Diffview open" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>",  desc = "File history" },
    },
    opts = {},
  },

  -- Copy GitHub permalink to current line or selection
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {},
    keys = {
      { "<leader>gy", "<cmd>GitLink<cr>",  mode = { "n", "v" }, desc = "Copy git link" },
      { "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
    },
  },

  -- Git integration
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gs", vim.cmd.Git, desc = "Git status" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { section_separators = "", component_separators = "" },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "filetype" },
          lualine_y = {},
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Keybinding hints popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Trouble for diagnostics
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
      { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>",    desc = "Quickfix List (Trouble)" },
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    },
  },

  -- Python virtualenv selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    ft = "python",
    keys = {
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python venv" },
    },
    opts = {
      settings = {
        search = {
          venv = { patterns = { ".venv" } },
        },
      },
    },
  },

  -- Formatter (independent of LSP)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        lua        = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json       = { "prettier" },
        markdown   = { "prettier" },
      },
      format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
    },
  },

  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "lua_ls", "basedpyright" },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            })
          end,
        },
      })

      -- sourcekit-lsp (Swift) — ships with the Swift toolchain, not managed by Mason
      vim.lsp.config('sourcekit', {
        cmd = { 'sourcekit-lsp' },
        filetypes = { 'swift' },
        root_markers = { 'Package.swift', '.git' },
      })
      vim.lsp.enable('sourcekit')

      -- LSP keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
          vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol,
            vim.tbl_extend("force", opts, { desc = "Workspace symbol" }))
          vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float,
            vim.tbl_extend("force", opts, { desc = "Open diagnostic float" }))
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Prev diagnostic" }))
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
          vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action,
            vim.tbl_extend("force", opts, { desc = "Code action" }))
          vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references,
            vim.tbl_extend("force", opts, { desc = "References" }))
          vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename,
            vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
          vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help,
            vim.tbl_extend("force", opts, { desc = "Signature help" }))
        end,
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN]  = "W",
            [vim.diagnostic.severity.HINT]  = "H",
            [vim.diagnostic.severity.INFO]  = "I",
          },
        },
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"]     = cmp.mapping.select_prev_item(cmp_select),
          ["<C-n>"]     = cmp.mapping.select_next_item(cmp_select),
          ["<C-y>"]     = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- Disable completion in markdown files
      cmp.setup.filetype("markdown", {
        sources = {},
      })
    end,
  },
})
