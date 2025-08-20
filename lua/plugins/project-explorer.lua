return {
  'Rics-Dev/project-explorer.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    paths = { '~/Desktop' }, --custom path set by user
    -- custom find command set by the user. Default should always work on unix unless user has heavily modified tools and/or PATH
    -- for Windows Users: installing `fd` is recommended with the equivalent `fd` command
    -- "fd . %s -td --min-depth %d --max-depth %d"
    command_pattern = "find %s -mindepth %d -maxdepth %d -type d -not -name '.git'",
    newProjectPath = '~/Desktop/', --custom path for new projects
    file_explorer = function(dir)
      require('oil').open(dir)
    end,
  },
  config = function(_, opts)
    require('project_explorer').setup(opts)
  end,
  keys = {
    { '<leader>fp', '<cmd>ProjectExplorer<cr>', desc = 'Project Explorer' },
  },
  lazy = false,
}
