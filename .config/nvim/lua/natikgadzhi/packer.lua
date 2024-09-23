-- Only required if you have packer configured as `opt`
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use "wbthomason/packer.nvim"

    -- surround quotes and ( manipulation
    use "tpope/vim-surround"

    use "christoomey/vim-tmux-navigator"

    -- UI to navigate the project
    use {
        "nvim-telescope/telescope.nvim", tag = '0.1.4',
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    use({
        "projekt0n/github-nvim-theme",
        config = function()
            require('github-theme').setup({
                -- ...
            })

            -- vim.cmd('colorscheme github_dark_tritanopia')
        end
    })

    -- Makes syntax highlighting work for most languages.
    use("nvim-treesitter/nvim-treesitter", { run = ':TSUpdate' })
    use "nvim-treesitter/nvim-treesitter-context"

    use "mbbill/undotree"
    use "tpope/vim-fugitive"
    use "lewis6991/gitsigns.nvim"

    use {
        "nvim-lualine/lualine.nvim",
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    }

    use {
        "VonHeikemen/lsp-zero.nvim",
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
end)
