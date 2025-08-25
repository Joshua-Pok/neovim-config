-- ~/.config/nvim/lua/config/init.lua
-- Main configuration loader

-- Load core configuration
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.health'
require('config.lsp').setup()

