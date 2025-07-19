return  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'hyper',
        config = {
          header = {
            '',
            '       ██╗ ██████╗ ███████╗██╗  ██╗██╗   ██╗ █████╗    ',
            '       ██║██╔═══██╗██╔════╝██║  ██║██║   ██║██╔══██╗   ',
            '       ██║██║   ██║███████╗███████║██║   ██║███████║   ',
            '  ██   ██║██║   ██║╚════██║██╔══██║██║   ██║██╔══██║   ',
            '  ╚█████╔╝╚██████╔╝███████║██║  ██║╚██████╔╝██║  ██║   ',
            '   ╚════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ',
            '',
          },

          center = {
            {
              icon = '  ',
              icon_hl = 'Title',
              desc = 'New File          ',
              desc_hl = 'String',
              key = 'n',
              keymap = 'SPC f n',
              key_hl = 'Number',
              action = 'enew',
            },
            {
              icon = '  ',
              icon_hl = 'Title',
              desc = 'Find File         ',
              desc_hl = 'String',
              key = 'f',
              keymap = 'SPC f f',
              key_hl = 'Number',
              action = 'Telescope find_files',
            },
            {
              icon = 'פּ  ',
              icon_hl = 'Title',
              desc = 'Recent Files      ',
              desc_hl = 'String',
              key = 'r',
              keymap = 'SPC f r',
              key_hl = 'Number',
              action = 'Telescope oldfiles',
            },
            {
              icon = '  ',
              icon_hl = 'Title',
              desc = 'Config            ',
              desc_hl = 'String',
              key = 'c',
              keymap = 'SPC f c',
              key_hl = 'Number',
              action = 'edit ~/.config/nvim/init.lua',
            },
            {
              icon = '  ',
              icon_hl = 'Title',
              desc = 'Quit              ',
              desc_hl = 'String',
              key = 'q',
              keymap = 'SPC q',
              key_hl = 'Number',
              action = 'qa',
            },
          },
        },
      }
    end,

    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  }