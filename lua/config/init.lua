-- ~/.config/nvim/lua/config/init.lua
-- Main configuration loader

-- Load core configuration
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.health'
require('config.lsp').setup()

vim.cmd 'packadd nvim.undotree'

pcall(vim.pack.add, { 'https://github.com/otavioschwanck/arrow.nvim' })
require('arrow').setup {
  show_icons = true,
  leader_key = ';',
  buffer_leader_key = 'm',
}

-- autopairs
pcall(vim.pack.add, { 'https://github.com/windwp/nvim-autopairs' })
require('nvim-autopairs').setup()

-- telescope and all extensions (telescope must be early since many plugins depend on it)
pcall(vim.pack.add, { 'https://github.com/nvim-lua/plenary.nvim' })
pcall(vim.pack.add, { 'https://github.com/nvim-tree/nvim-web-devicons' })
pcall(vim.pack.add, { 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' })
pcall(vim.pack.add, { 'https://github.com/nvim-telescope/telescope-ui-select.nvim' })
pcall(vim.pack.add, { 'https://github.com/nvim-telescope/telescope-live-grep-args.nvim' })
pcall(vim.pack.add, { 'https://github.com/debugloop/telescope-undo.nvim' })
pcall(vim.pack.add, { 'https://github.com/piersolenski/telescope-import.nvim' })
pcall(vim.pack.add, { 'https://github.com/nvim-telescope/telescope-file-browser.nvim' })
pcall(vim.pack.add, { 'https://github.com/nvim-telescope/telescope.nvim' })

require('telescope').setup {
  defaults = {
    preview = { enable = true },
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
  },
  extensions = {
    undo = {},
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
    file_browser = { hijack_netrw = true, previewer = true },
    media_files = {
      filetypes = { 'png', 'webp', 'jpg', 'jpeg', 'pdf' },
      find_cmd = 'rg',
      preview = { width = 0.7, height = 0.7 },
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
pcall(require('telescope').load_extension, 'projects')
pcall(require('telescope').load_extension, 'file_browser')
pcall(require('telescope').load_extension, 'live_grep_args')
pcall(require('telescope').load_extension, 'undo')
pcall(require('telescope').load_extension, 'import')

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>fu', '<cmd>Telescope undo<cr>', { desc = 'Undo history' })
vim.keymap.set('n', '<leader>fi', '<cmd>Telescope import<cr>', { desc = 'Import' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>fg', function()
  require('telescope').extensions.live_grep_args.live_grep_args()
end, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>fp', '<cmd>Telescope projects<cr>', { desc = 'Search Projects' })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope file_browser<CR>')
vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
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

-- ts-autotag
pcall(vim.pack.add, { 'https://github.com/tronikelis/ts-autotag.nvim' })
require('ts-autotag').setup {
  enable_close = true,
  enable_rename = true,
  enable_close_on_slash = false,
}

-- cinnamon
pcall(vim.pack.add, { 'https://github.com/declancm/cinnamon.nvim' })
require('cinnamon').setup()

-- colorful-menu
pcall(vim.pack.add, { 'https://github.com/xzbdmw/colorful-menu.nvim' })
require('colorful-menu').setup {
  ls = {
    lua_ls = { arguments_hl = '@comment' },
    gopls = {
      align_type_to_right = true,
      add_colon_before_type = false,
      preserve_type_when_truncate = true,
    },
    ts_ls = { extra_info_hl = '@comment' },
    vtsls = { extra_info_hl = '@comment' },
    ['rust-analyzer'] = {
      extra_info_hl = '@comment',
      align_type_to_right = true,
      preserve_type_when_truncate = true,
    },
    clangd = {
      extra_info_hl = '@comment',
      align_type_to_right = true,
      import_dot_hl = '@comment',
      preserve_type_when_truncate = true,
    },
    zls = { align_type_to_right = true },
    roslyn = { extra_info_hl = '@comment' },
    dartls = { extra_info_hl = '@comment' },
    pyright = { extra_info_h1 = '@comment' },
    basedpyright = { extra_info_hl = '@comment' },
    pylsp = {
      extra_info_hl = '@comment',
      arguments_hl = '@comment',
    },
    fallback = true,
    fallback_extra_info_hl = '@comment',
  },
  fallback_highlight = '@variable',
  max_width = 60,
}

-- colorizer
pcall(vim.pack.add, { 'https://github.com/norcalli/nvim-colorizer.lua' })
require('colorizer').setup()

-- conform
pcall(vim.pack.add, { 'https://github.com/stevearc/conform.nvim' })
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    local disable_filetypes = { c = true, cpp = true }
    if disable_filetypes[vim.bo[bufnr].filetype] then
      return nil
    else
      return {
        timeout_ms = 500,
        lsp_format = 'fallback',
      }
    end
  end,
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
    javascriptreact = { 'prettier' },
  },
}
vim.keymap.set('', '<leader>F', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer' })

-- diffview
pcall(vim.pack.add, { 'https://github.com/nvim-lua/plenary.nvim' })
pcall(vim.pack.add, { 'https://github.com/sindrets/diffview.nvim' })
require('diffview').setup {
  enhanced_diff_hl = true,
  view = {
    merge_tool = {
      layout = 'diff3_mixed',
    },
  },
}
vim.keymap.set('n', '<leader>gid', '<cmd>DiffviewOpen<cr>', { desc = 'Diffview: open' })
vim.keymap.set('n', '<leader>giD', '<cmd>DiffviewClose<cr>', { desc = 'Diffview: close' })

-- flash
pcall(vim.pack.add, { 'https://github.com/folke/flash.nvim' })
require('flash').setup()
vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
  require('flash').jump()
end, { desc = 'Flash' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function()
  require('flash').treesitter()
end, { desc = 'Flash Treesitter' })
vim.keymap.set('o', 'r', function()
  require('flash').remote()
end, { desc = 'Remote Flash' })
vim.keymap.set({ 'o', 'x' }, 'R', function()
  require('flash').treesitter_search()
end, { desc = 'Treesitter Search' })
vim.keymap.set('c', '<c-s>', function()
  require('flash').toggle()
end, { desc = 'Toggle Flash Search' })

-- gitsigns
pcall(vim.pack.add, { 'https://github.com/lewis6991/gitsigns.nvim' })
require('gitsigns').setup {
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Jump to next git [c]hange' })
    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Jump to previous git [c]hange' })
    map('v', '<leader>hs', function()
      gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'git [s]tage hunk' })
    map('v', '<leader>hr', function()
      gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'git [r]eset hunk' })
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
    map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
    map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
    map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
    map('n', '<leader>hD', function()
      gitsigns.diffthis '@'
    end, { desc = 'git [D]iff against last commit' })
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
    map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
  end,
}

-- goto-preview
pcall(vim.pack.add, { 'https://github.com/rmagatti/goto-preview' })
require('goto-preview').setup {
  width = 120,
  height = 25,
  default_mappings = false,
  debug = false,
  opacity = nil,
  resizing_mappings = false,
  post_open_hook = nil,
  references = {
    telescope = require('telescope.themes').get_dropdown { hide_preview = false },
  },
  focus_on_open = true,
  dismiss_on_move = false,
  force_close = true,
  bufhidden = 'wipe',
}
local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'gpd', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opts)
vim.keymap.set('n', 'gpt', "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", opts)
vim.keymap.set('n', 'gpi', "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", opts)
vim.keymap.set('n', 'gpD', "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", opts)
vim.keymap.set('n', 'gpr', "<cmd>lua require('goto-preview').goto_preview_references()<CR>", opts)
vim.keymap.set('n', 'gP', "<cmd>lua require('goto-preview').close_all_win()<CR>", opts)

-- hlslens
pcall(vim.pack.add, { 'https://github.com/kevinhwang91/nvim-hlslens' })
require('hlslens').setup {
  calm_down = true,
  nearest_only = true,
  virt_priority = 0,
  nearest_float_when = 'always',
}

-- hover
pcall(vim.pack.add, { 'https://github.com/lewis6991/hover.nvim' })
require('hover').config {
  providers = {
    'hover.providers.lsp',
    'hover.providers.man',
    'hover.providers.dictionary',
  },
  preview_opts = { border = 'rounded' },
  preview_window = false,
  title = true,
  mouse_providers = { 'hover.providers.lsp' },
  mouse_delay = 1000,
}
vim.keymap.set('n', 'K', function()
  require('hover').open()
end, { desc = 'hover.nvim (open)' })
vim.keymap.set('n', 'gK', function()
  require('hover').enter()
end, { desc = 'hover.nvim (enter)' })
vim.keymap.set('n', '<C-p>', function()
  require('hover').hover_switch 'previous'
end, { desc = 'hover.nvim (previous source)' })
vim.keymap.set('n', '<C-n>', function()
  require('hover').hover_switch 'next'
end, { desc = 'hover.nvim (next source)' })
vim.keymap.set('n', '<MouseMove>', function()
  require('hover').mouse()
end, { desc = 'hover.nvim (mouse)' })
vim.o.mousemoveevent = true

-- image.nvim
pcall(vim.pack.add, { 'https://github.com/3rd/image.nvim' })
require('image').setup {
  backend = 'kitty',
}

-- indent-blankline
pcall(vim.pack.add, { 'https://github.com/lukas-reineke/indent-blankline.nvim' })
require('ibl').setup()

-- lazydev
pcall(vim.pack.add, { 'https://github.com/folke/lazydev.nvim' })
require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

-- lazygit
pcall(vim.pack.add, { 'https://github.com/nvim-lua/plenary.nvim' })
pcall(vim.pack.add, { 'https://github.com/kdheepak/lazygit.nvim' })
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })

-- nvim-lint
pcall(vim.pack.add, { 'https://github.com/mfussenegger/nvim-lint' })
local lint = require 'lint'
lint.linters_by_ft = {
  markdown = { 'markdownlint' },
}
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    if vim.bo.modifiable then
      lint.try_lint()
    end
  end,
})

-- marks
pcall(vim.pack.add, { 'https://github.com/chentoast/marks.nvim' })
require('marks').setup()

-- nvim-cmp and all dependencies
pcall(vim.pack.add, { 'https://github.com/rafamadriz/friendly-snippets' })
pcall(vim.pack.add, { 'https://github.com/L3MON4D3/LuaSnip' })
pcall(vim.pack.add, { 'https://github.com/saadparwaiz1/cmp_luasnip' })
pcall(vim.pack.add, { 'https://github.com/hrsh7th/cmp-nvim-lsp' })
pcall(vim.pack.add, { 'https://github.com/hrsh7th/cmp-buffer' })
pcall(vim.pack.add, { 'https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol' })
pcall(vim.pack.add, { 'https://github.com/hrsh7th/cmp-path' })
pcall(vim.pack.add, { 'https://github.com/hrsh7th/cmp-cmdline' })
pcall(vim.pack.add, { 'https://github.com/hrsh7th/cmp-nvim-lua' })
pcall(vim.pack.add, { 'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help' })
pcall(vim.pack.add, { 'https://github.com/hrsh7th/nvim-cmp' })

local cmp = require 'cmp'
local luasnip = require 'luasnip'
local select_opts = { behavior = cmp.SelectBehavior.Select }
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered { border = 'rounded', max_width = 60, max_height = 10 },
    documentation = cmp.config.window.bordered { border = 'rounded', max_width = 60, max_height = 10 },
  },
  mapping = cmp.mapping.preset.insert {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'nvim_lsp_signature_help' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
  formatting = {
    format = function(entry, vim_item)
      local highlights_info = require('colorful-menu').cmp_highlights(entry)
      if highlights_info ~= nil then
        vim_item.abbr_hl_group = highlights_info.highlights
        vim_item.abbr = highlights_info.text
      end
      local kind_icons = {
        Text = '',
        Method = '󰆧',
        Function = '󰊕',
        Constructor = '',
        Field = '󰇽',
        Variable = '󰂡',
        Class = '󰠱',
        Interface = '',
        Module = '',
        Property = '󰜢',
        Unit = '',
        Value = '󰎠',
        Enum = '',
        Keyword = '󰌋',
        Snippet = '',
        Color = '󰏘',
        File = '󰈙',
        Reference = '',
        Folder = '󰉋',
        EnumMember = '',
        Constant = '󰏿',
        Struct = '',
        Event = '',
        Operator = '󰆕',
        TypeParameter = '󰅲',
      }
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        luasnip = '[Snippet]',
        buffer = '[Buffer]',
        path = '[Path]',
        nvim_lua = '[Lua]',
        nvim_lsp_signature_help = '[Signature]',
      })[entry.source.name]
      return vim_item
    end,
  },
}
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources { { name = 'buffer' } },
})
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' },
  }, {
    { name = 'buffer' },
  }),
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
})

-- alpha-nvim
pcall(vim.pack.add, { 'https://github.com/amansingh-afk/milli.nvim' })
pcall(vim.pack.add, { 'https://github.com/goolord/alpha-nvim' })
local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'
local splash = require('milli').load { splash = 'vibecat', loop = true }
dashboard.section.header.val = splash.frames[1]
dashboard.section.header.opts.hl = 'AlphaHeader'
require('milli').alpha { splash = 'vibecat', loop = true }
dashboard.section.buttons.val = {
  dashboard.button('f', '󰈙  Find file', ':Telescope find_files<CR>'),
  dashboard.button('r', '  Recent files', ':Telescope oldfiles<CR>'),
  dashboard.button('g', '  Find text', ':Telescope live_grep<CR>'),
  dashboard.button('p', '  Projects', ':Telescope projects<CR>'),
  dashboard.button('q', '  Quit', ':qa<CR>'),
}
alpha.setup(dashboard.opts)

-- noice
pcall(vim.pack.add, { 'https://github.com/MunifTanjim/nui.nvim' })
pcall(vim.pack.add, { 'https://github.com/rcarriga/nvim-notify' })
require('notify').setup { background_colour = '#000000' }
vim.notify = require 'notify'
pcall(vim.pack.add, { 'https://github.com/folke/noice.nvim' })
require('noice').setup()

-- nvim-lspconfig + mason
pcall(vim.pack.add, { 'https://github.com/mason-org/mason.nvim' })
pcall(vim.pack.add, { 'https://github.com/mason-org/mason-lspconfig.nvim' })
pcall(vim.pack.add, { 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' })
pcall(vim.pack.add, { 'https://github.com/neovim/nvim-lspconfig' })

require('mason').setup()

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
    map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
    map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end
    if client and client:supports_method 'textDocument/codeLens' then
      vim.lsp.codelens.refresh { bufnr = event.buf }
      vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        buffer = event.buf,
        callback = function()
          vim.lsp.codelens.refresh { bufnr = event.buf }
        end,
      })
    end
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
      local inlay_hints_group = vim.api.nvim_create_augroup('LSP_inlayHints', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = inlay_hints_group,
        buffer = event.buf,
        callback = function()
          local row = vim.api.nvim_win_get_cursor(0)[1]
          vim.lsp.inlay_hint.enable(true, {
            bufnr = event.buf,
            filter = function(hint)
              return hint.position.line + 1 == row
            end,
          })
        end,
      })
    end
  end,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = {
  clangd = {},
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          fieldalignment = true,
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
        semanticTokens = true,
      },
    },
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          autoImportCompletions = true,
          autoSearchPaths = true,
          diagnosticMode = 'workspace',
          useLibraryCodeForTypes = true,
        },
      },
    },
  },
  ruff = {},
  ts_ls = {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
        suggest = { includeCompletionsForModuleExports = true, autoImports = true },
        preferences = { includePackageJsonAutoImports = 'auto' },
      },
      javascript = {
        suggest = { includeCompletionsForModuleExports = true, autoImports = true },
        preferences = { includePackageJsonAutoImports = 'auto' },
      },
    },
  },
  eslint = {},
  html = {},
  cssls = {},
  lua_ls = {
    settings = { Lua = { completion = { callSnippet = 'Replace' } } },
  },
}
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, { 'stylua' })
require('mason-tool-installer').setup { ensure_installed = ensure_installed }
require('mason-lspconfig').setup {
  ensure_installed = {},
  automatic_installation = false,
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}

-- debugmaster
pcall(vim.pack.add, { 'https://github.com/mfussenegger/nvim-dap' })
pcall(vim.pack.add, { 'https://github.com/jbyuki/one-small-step-for-vimkind' })
pcall(vim.pack.add, { 'https://github.com/miroshQa/debugmaster.nvim' })
local dm = require 'debugmaster'
vim.keymap.set({ 'n', 'v' }, '<leader>d', dm.mode.toggle, { nowait = true })
vim.keymap.set('t', '<C-\\>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
dm.plugins.osv_integration.enabled = true

-- lualine
pcall(vim.pack.add, { 'https://github.com/nvim-lualine/lualine.nvim' })
require('lualine').setup {
  options = { theme = 'powerline_dark' },
  sections = {
    lualine_c = { { 'filename', path = 2 } },
  },
}

-- nvim-spider
pcall(vim.pack.add, { 'https://github.com/chrisgrieser/nvim-spider' })
vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>")
vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>")
vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>")

-- nvim-surround
pcall(vim.pack.add, { 'https://github.com/kylechui/nvim-surround' })
require('nvim-surround').setup()

-- nvim-various-textobjs
pcall(vim.pack.add, { 'https://github.com/chrisgrieser/nvim-various-textobjs' })
require('various-textobjs').setup { keymaps = { useDefaults = true } }

-- oasis.nvim (colorscheme, load first)
pcall(vim.pack.add, { 'https://github.com/uhs-robert/oasis.nvim' })
require('oasis').setup()
vim.cmd.colorscheme 'oasis-midnight'

-- oil.nvim
pcall(vim.pack.add, { 'https://github.com/stevearc/oil.nvim' })
require('oil').setup()
vim.keymap.set('n', '<leader>o', '<cmd>Oil<cr>', { desc = 'Open Oil file explorer' })

-- nvim-origami
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
pcall(vim.pack.add, { 'https://github.com/chrisgrieser/nvim-origami' })
require('origami').setup()

-- render-markdown
pcall(vim.pack.add, { 'https://github.com/echasnovski/mini.nvim' })
require('mini.move').setup()
pcall(vim.pack.add, { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })
require('render-markdown').setup { treesitter = false }

-- smart-splits
pcall(vim.pack.add, { 'https://github.com/mrjones2014/smart-splits.nvim' })
require('smart-splits').setup()
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)

-- smear-cursor
pcall(vim.pack.add, { 'https://github.com/sphamba/smear-cursor.nvim' })
require('smear_cursor').setup {
  cursor_color = '#d3cdc3',
  normal_bg = '#282828',
  smear_between_buffers = true,
  smear_between_neighbor_lines = true,
  use_floating_windows = true,
  legacy_computing_symbols_support = false,
}

-- todo-comments
pcall(vim.pack.add, { 'https://github.com/folke/todo-comments.nvim' })
require('todo-comments').setup { signs = false }

-- trouble
pcall(vim.pack.add, { 'https://github.com/folke/trouble.nvim' })
require('trouble').setup {
  win = { position = 'right', type = 'split', relative = 'win', size = 0.3 },
}
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols (Trouble)' })
vim.keymap.set('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'LSP Definitions / references / ...' })
vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Location List (Trouble)' })
vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix List (Trouble)' })

-- vim-visual-multi
pcall(vim.pack.add, { 'https://github.com/mg979/vim-visual-multi' })

-- which-key
pcall(vim.pack.add, { 'https://github.com/folke/which-key.nvim' })
require('which-key').setup {
  delay = 0,
  icons = {
    mappings = vim.g.have_nerd_font,
    keys = vim.g.have_nerd_font and {} or {
      Up = '<Up> ',
      Down = '<Down> ',
      Left = '<Left> ',
      Right = '<Right> ',
      C = '<C-…> ',
      M = '<M-…> ',
      D = '<D-…> ',
      S = '<S-…> ',
      CR = '<CR> ',
      Esc = '<Esc> ',
      ScrollWheelDown = '<ScrollWheelDown> ',
      ScrollWheelUp = '<ScrollWheelUp> ',
      NL = '<NL> ',
      BS = '<BS> ',
      Space = '<Space> ',
      Tab = '<Tab> ',
      F1 = '<F1>',
      F2 = '<F2>',
      F3 = '<F3>',
      F4 = '<F4>',
      F5 = '<F5>',
      F6 = '<F6>',
      F7 = '<F7>',
      F8 = '<F8>',
      F9 = '<F9>',
      F10 = '<F10>',
      F11 = '<F11>',
      F12 = '<F12>',
    },
  },
  spec = {
    { '<leader>s', group = '[S]earch' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
  },
}

-- winshift
pcall(vim.pack.add, { 'https://github.com/sindrets/winshift.nvim' })
require('winshift').setup()
vim.keymap.set('n', '<leader>w', '<cmd>WinShift<CR>', { desc = 'WinShift mode' })

pcall(vim.pack.add, { 'https://github.com/nvim-treesitter/nvim-treesitter' })

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
