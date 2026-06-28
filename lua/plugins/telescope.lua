return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    -- fzf-native requires a build step, which lazy.nvim handles perfectly here
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    'debugloop/telescope-undo.nvim',
    'piersolenski/telescope-import.nvim',
    'nvim-telescope/telescope-file-browser.nvim',

    -- Note: Your original snippet referenced `projects` and `media_files` in
    -- the config/extensions, but didn't have their URLs. I've added standard ones:
    'nvim-telescope/telescope-media-files.nvim',
    'ahmedkhalf/project.nvim',
  },
  config = function()
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'
    local themes = require 'telescope.themes'
    local previewers = require 'telescope.previewers'

    telescope.setup {
      defaults = {
        preview = { enable = true },
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
      },
      extensions = {
        undo = {},
        ['ui-select'] = { themes.get_dropdown() },
        file_browser = { hijack_netrw = true, previewer = true },
        media_files = {
          filetypes = { 'png', 'webp', 'jpg', 'jpeg', 'pdf' },
          find_cmd = 'rg',
          preview = { width = 0.7, height = 0.7 },
        },
      },
    }

    -- Load extensions safely via a loop to keep it clean
    local extensions = {
      'fzf',
      'ui-select',
      'projects',
      'file_browser',
      'live_grep_args',
      'undo',
      'import',
    }

    for _, ext in ipairs(extensions) do
      pcall(telescope.load_extension, ext)
    end

    -- Keymaps
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>fu', '<cmd>Telescope undo<cr>', { desc = 'Undo history' })
    vim.keymap.set('n', '<leader>fi', '<cmd>Telescope import<cr>', { desc = 'Import' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[S]earch current [W]ord' })

    vim.keymap.set('n', '<leader>fg', function()
      telescope.extensions.live_grep_args.live_grep_args()
    end, { desc = '[S]earch by [G]rep' })

    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>fp', '<cmd>Telescope projects<cr>', { desc = 'Search Projects' })
    vim.keymap.set('n', '<leader>fb', '<cmd>Telescope file_browser<CR>')

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(themes.get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
    end, { desc = '[S]earch [/] in Open Files' })

    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
