return {
  'luukvbaal/statuscol.nvim',
  dependencies = { 'lewis6991/gitsigns.nvim' },
  config = function()
    local builtin = require 'statuscol.builtin'
    vim.opt.signcolumn = 'yes'
    require('statuscol').setup {
      relculright = true,
      segments = {
        -- Git signs
        {
          text = { builtin.signcolumn },
          click = 'v:lua.ScSa',
        },
        {
          text = {
            function(args)
              local diags = vim.diagnostic.get(0, { lnum = args.lnum - 1 })
              if #diags > 0 then
                return '😫'
              else
                return ' '
              end
            end,
          },
          hl = 'DiagnosticError',
        },
        -- TODO/FIXME marker
        {
          text = {
            function(args)
              local line = vim.fn.getline(args.lnum)
              if line:match 'TODO' or line:match 'FIXME' then
                return '✏️'
              else
                return ''
              end
            end,
          },
          hl = 'Todo',
        },
        -- Absolute line numbers
        {
          text = {
            function(args)
              return tostring(args.lnum)
            end,
          },
          click = 'v:lua.ScLa',
        },
        -- Separator
        {
          text = { '|' },
          hl = 'StatusColumnSeparator',
        },
        -- Relative line numbers
        {
          text = {
            function(args)
              return args.relnum > 0 and tostring(args.relnum) or ''
            end,
          },
          click = 'v:lua.ScLa',
        },
      },
    }

    vim.api.nvim_set_hl(0, 'StatusColumnSeparator', { fg = '#666666' })
  end,
}
