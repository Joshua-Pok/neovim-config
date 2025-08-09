return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- Set custom ASCII art header
    dashboard.section.header.val = {
      '                                                     ',
      '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
      '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
      '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
      '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
      '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
      '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
      '                                                     ',
    }

    -- Set custom menu buttons
    dashboard.section.buttons.val = {
      dashboard.button('e', '  > New file', ':ene <BAR> startinsert <CR>'),
      dashboard.button('f', '  > Find file', ':Telescope find_files<CR>'),
      dashboard.button('r', '  > Recent files', ':Telescope oldfiles<CR>'),
      dashboard.button('g', '  > Find text', ':Telescope live_grep<CR>'),
      dashboard.button('d', '  > Dotfiles', ':cd ~/.config | e .<CR>'),
      dashboard.button('c', '  > Config', ':e $MYVIMRC | :cd %:p:h<CR>'),
      dashboard.button('q', '  > Quit NVIM', ':qa<CR>'),
    }

    -- Optional: Add footer
    local function footer()
      return 'Happy coding! 🚀'
    end
    dashboard.section.footer.val = footer()

    -- Send config to alpha
    alpha.setup(dashboard.opts)
  end,
}
