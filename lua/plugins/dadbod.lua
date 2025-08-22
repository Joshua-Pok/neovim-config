return {
  'tpope/vim-dadbod',
  dependencies = {
    'kristijanhusak/vim-dadbod-ui',
    'kristijanhusak/vim-dadbod-completion',
  },
  config = function()
    -- Optional: Set up completion for SQL files
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'sql', 'mysql', 'plsql' },
      callback = function()
        require('cmp').setup.buffer {
          sources = {
            { name = 'vim-dadbod-completion' },
            { name = 'buffer' },
          },
        }
      end,
    })
  end,
  cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection' },
  keys = {
    { '<leader>db', '<cmd>DBUIToggle<cr>', desc = 'Toggle DBUI' },
  },
}
