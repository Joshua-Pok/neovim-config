return {
  'ThePrimeagen/git-worktree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    { '<leader>gws', ':Telescope git_worktree git_worktrees<CR>', desc = 'Switch worktree' },
    { '<leader>gwc', ':Telescope git_worktree create_git_worktree<CR>', desc = 'Create worktree' },
  },
  config = function()
    require('git-worktree').setup {}
    -- Assuming Telescope is already set up in its own file, we just load the extension here
    require('telescope').load_extension 'git_worktree'
  end,
}
