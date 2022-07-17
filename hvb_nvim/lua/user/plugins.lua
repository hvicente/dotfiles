local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff, integration with commentstring
  --use 'terrortylor/nvim-comment'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use "akinsho/bufferline.nvim" -- Graphics addons as gui nvim
  use "moll/vim-bbye" -- Allows closing files (delete buffers) without closing windows
  use 'nvim-lualine/lualine.nvim' -- Fast status bar
  use "akinsho/toggleterm.nvim" -- Open and close terminal
  use 'lewis6991/impatient.nvim' -- Improves startup time
  use "lukas-reineke/indent-blankline.nvim" -- Allows coloring indentation
  use 'goolord/alpha-nvim' -- Welcome screen
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim" -- Show key help
   
  -- Colorschemes
  use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  --use "lunarvim/darkplus.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  --use "L3MON4D3/LuaSnip" --snippet engine
  --use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  --use "neovim/nvim-lspconfig" -- enable LSP
  --use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  --use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for

  -- Improve jk esc
  use { 'jdhao/better-escape.vim', event = 'InsertEnter' }

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use 'nvim-telescope/telescope-media-files.nvim'

  -- Treesitter, enhance hightlight
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  use 'JoosepAlviste/nvim-ts-context-commentstring' --Improved commenting

  -- Git
  use "lewis6991/gitsigns.nvim" -- Add blame and modification gutter

  -- HVB Postman alternative to test
  use { "NTBBloodbath/rest.nvim", requires = { "nvim-lua/plenary.nvim" } }

  use { 'neoclide/coc.nvim', branch = 'release' }

  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
