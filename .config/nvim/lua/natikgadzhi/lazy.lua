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

    -- File tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
            { "<leader>-", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
        },
        opts = {},
    },

    -- Telescope fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>pf", function() require("telescope.builtin").find_files() end,                              desc = "Find files" },
            { "<C-p>",      function() require("telescope.builtin").git_files() end,                               desc = "Git files" },
            { "<leader>pg", function() require("telescope.builtin").live_grep() end,                               desc = "Live grep" },
            { "<leader>pb", function() require("telescope.builtin").buffers() end,                                 desc = "Buffers" },
            { "<leader>ps", function() require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") }) end, desc = "Grep string" },
        },
    },

    -- GitHub theme
    {
        "projekt0n/github-nvim-theme",
        lazy = false,
        priority = 1000,
        config = function()
            require("github-theme").setup({})
            vim.cmd("colorscheme github_dark_tritanopia")
        end,
    },

    -- Treesitter for syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "typescript" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPost",
    },

    -- Undotree
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
        },
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
                options = { section_separators = "", component_separators = "" }
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
        branch = "regexp",
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

            -- LSP keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local opts = { buffer = args.buf }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
                    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, vim.tbl_extend("force", opts, { desc = "Workspace symbol" }))
                    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Open diagnostic float" }))
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Prev diagnostic" }))
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
                    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
                    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
                    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
                    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
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
        end,
    },
})
