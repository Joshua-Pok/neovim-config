return {
  'retran/meow.yarn.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  keys = {
    {
      '<leader>myt',
      function()
        require('meow.yarn').open_tree('type_hierarchy', 'supertypes')
      end,
      desc = 'Yarn: Type Hierarchy (Super)',
    },
    {
      '<leader>myT',
      function()
        require('meow.yarn').open_tree('type_hierarchy', 'subtypes')
      end,
      desc = 'Yarn: Type Hierarchy (Sub)',
    },
    {
      '<leader>myc',
      function()
        require('meow.yarn').open_tree('call_hierarchy', 'callers')
      end,
      desc = 'Yarn: Call Hierarchy (Callers)',
    },
    {
      '<leader>myC',
      function()
        require('meow.yarn').open_tree('call_hierarchy', 'callees')
      end,
      desc = 'Yarn: Call Hierarchy (Callees)',
    },
  },
  config = function()
    require('meow.yarn').setup {
      -- Your custom configuration goes here
    }
  end,
}
