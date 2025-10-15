return {
  'maskudo/devdocs.nvim',
  lazy = false,
  dependencies = {
    'folke/snacks.nvim',
  },
  cmd = { 'DevDocs' },
  keys = {
    {
      '<leader>ho',
      '<cmd>DevDocs get<cr>',
      mode = 'n',
      desc = 'Get Devdocs',
    },
    {
      '<leader>hi',
      '<cmd>DevDocs install<cr>',
      mode = 'n',
      desc = 'Install Devdocs',
    },
    {
      '<leader>hv',
      function()
        local devdocs = require 'devdocs'
        local installedDocs = devdocs.GetInstalledDocs()
        vim.ui.select(installedDocs, {}, function(selected)
          if not selected then
            return
          end
          local docDir = devdocs.GetDocDir(selected)
          -- prettify the filename as you wish
          Snacks.picker.files { cwd = docDir }
        end)
      end,
      mode = 'n',
      desc = 'View Installed Devdocs',
    },
    {
      '<leader>hd',
      '<cmd>DevDocs delete<cr>',
      mode = 'n',
      desc = 'Delete Devdoc',
    },
  },
  opts = {
    ensure_installed = {
      'go',
      'html',
      'http',
      'lua~5.1',
      -- "css",
      -- "javascript",
      -- "rust",
      -- "openjdk~21",
    },
  },
}
