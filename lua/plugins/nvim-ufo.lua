return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  event = 'BufReadPost',
  config = function()
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99 -- Start with all folds open
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Set up view options for fold persistence
    vim.o.viewoptions = 'folds,cursor'
    vim.o.viewdir = vim.fn.expand '~/.config/nvim/view'

    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

    require('ufo').setup {
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    }

    -- Auto-save and restore folds
    vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
      pattern = '*',
      callback = function()
        if vim.bo.filetype ~= '' and vim.bo.buftype == '' then
          vim.cmd 'silent! mkview'
        end
      end,
    })

    vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
      pattern = '*',
      callback = function()
        if vim.bo.filetype ~= '' and vim.bo.buftype == '' then
          vim.cmd 'silent! loadview'
        end
      end,
    })
  end,
}
