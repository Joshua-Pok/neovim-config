return {
  'akinsho/toggleterm.nvim',
  version = '*',
  -- Tell Lazy to load the plugin when <C-t> is pressed in normal OR terminal mode
  keys = {
    { '<C-t>', mode = { 'n', 't' }, desc = 'Toggle floating terminal' },
    -- Keep the lazygit mapping here so Lazy knows about it
    { '<leader>tg', '<cmd>lua _G.toggle_lazygit()<cr>', desc = 'Toggle Lazygit' },
  },
  opts = {
    -- THIS is the magic bullet that makes closing work from inside the terminal
    open_mapping = [[<c-t>]],
    direction = 'float',
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,

    float_opts = {
      border = 'curved',
      width = math.floor(vim.o.columns * 0.8),
      height = math.floor(vim.o.lines * 0.8),
      winblend = 3,
    },
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    function _G.set_terminal_keymaps()
      local config = { buffer = 0 }

      -- Drop to normal mode inside the terminal buffer
      vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n>]], config)

      -- Tmux-friendly window navigation from inside the terminal
      vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-W>h]], config)
      vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-W>j]], config)
      vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-W>k]], config)
      vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-W>l]], config)
    end

    vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

    -- Dedicated Lazygit Terminal
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new {
      cmd = 'lazygit',
      hidden = true,
      direction = 'float',
      float_opts = { border = 'double' },
      on_close = function(_)
        vim.cmd 'startinsert!'
      end,
    }
  end,
}
