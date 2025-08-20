return {
  {
    'ahmedkhalf/project.nvim',
    event = 'VeryLazy',
    config = function()
      require('project_nvim').setup {
        -- detection methods: "lsp", "pattern"
        detection_methods = { 'lsp', 'pattern' },

        -- patterns to recognize project root
        patterns = { '.git', 'package.json', 'Makefile', 'src' },

        -- automatically change directory
        manual_mode = false,
        silent_chdir = true,
      }
    end,
  },

  -- (optional) Telescope integration
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').load_extension 'projects'
    end,
  },
}
