return {
  'hrsh7th/nvim-cmp',
  -- Load cmp on InsertEnter and CmdlineEnter to keep startup fast
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',

    -- Buffer, path, and cmdline sources
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',

    -- Neovim Lua API and Document Symbols
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp-document-symbol',

    -- Preconfigured snippet collections
    'rafamadriz/friendly-snippets',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local select_opts = { behavior = cmp.SelectBehavior.Select }

    -- Load friendly-snippets
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
          -- Assumes colorful-menu.nvim is already loaded/available
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

          -- Use a fallback empty string just in case kind is somehow nil
          vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind] or '', vim_item.kind)

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

    -- Filetype specific completion
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources { { name = 'buffer' } },
    })

    -- Search (/) cmdline completion
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = 'buffer' }, { name = 'nvim_lsp_document_symbol' } },
    })

    -- Command (:) cmdline completion
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
    })
  end,
}
