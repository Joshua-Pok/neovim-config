return {
  {
    'echasnovski/mini.nvim',
    version = false, -- Use the latest development features
    config = function()
      -- 1. Automatic pairs insertion as you type
      require('mini.pairs').setup {}

      -- 2. Move lines and visual selections seamlessly
      require('mini.move').setup {
        mappings = {
          -- Move lines in Normal mode
          left = '<M-h>',
          right = '<M-l>',
          down = '<M-j>',
          up = '<M-k>',

          -- Move selections in Visual mode
          line_left = '<M-h>',
          line_right = '<M-l>',
          line_down = '<M-j>',
          line_up = '<M-k>',
        },
      }

      -- 3. Add, delete, and replace surroundings
      require('mini.surround').setup {}
      require('mini.diff').setup {}

      -- 4. Smooth animations for scrolling, cursor, and windows
      require('mini.animate').setup {}
      require('mini.operators').setup {}
      require('mini.misc').setup_auto_root {}

      -- 5. File manager (mini.files)
      require 'mini.files'
      local nsMiniFiles = vim.api.nvim_create_namespace 'mini_files_git'
      local autocmd = vim.api.nvim_create_autocmd
      local MiniFiles = require 'mini.files'
      local gitStatusCache = {}
      local cacheTimeout = 2000 -- in milliseconds
      local uv = vim.uv or vim.loop

      local function isSymlink(path)
        local stat = uv.fs_lstat(path)
        return stat and stat.type == 'link'
      end

      local function mapSymbols(status, is_symlink)
        local statusMap = {
					-- stylua: ignore start
					[" M"] = { symbol = "•", hlGroup = "MiniDiffSignChange" },
					["M "] = { symbol = "✹", hlGroup = "MiniDiffSignChange" },
					["MM"] = { symbol = "≠", hlGroup = "MiniDiffSignChange" },
					["A "] = { symbol = "+", hlGroup = "MiniDiffSignAdd" },
					["AA"] = { symbol = "≈", hlGroup = "MiniDiffSignAdd" },
					["D "] = { symbol = "-", hlGroup = "MiniDiffSignDelete" },
					["AM"] = { symbol = "⊕", hlGroup = "MiniDiffSignChange" },
					["AD"] = { symbol = "-•", hlGroup = "MiniDiffSignChange" },
					["R "] = { symbol = "→", hlGroup = "MiniDiffSignChange" },
					["U "] = { symbol = "‖", hlGroup = "MiniDiffSignChange" },
					["UU"] = { symbol = "⇄", hlGroup = "MiniDiffSignAdd" },
					["UA"] = { symbol = "⊕", hlGroup = "MiniDiffSignAdd" },
					["??"] = { symbol = "?", hlGroup = "MiniDiffSignDelete" },
					["!!"] = { symbol = "!", hlGroup = "MiniDiffSignChange" },
          -- stylua: ignore end
        }

        local result = statusMap[status] or { symbol = '?', hlGroup = 'NonText' }
        local gitSymbol = result.symbol
        local gitHlGroup = result.hlGroup
        local symlinkSymbol = is_symlink and '↩' or ''

        local combinedSymbol = (symlinkSymbol .. gitSymbol):gsub('^%s+', ''):gsub('%s+$', '')
        local combinedHlGroup = is_symlink and 'MiniDiffSignDelete' or gitHlGroup

        return combinedSymbol, combinedHlGroup
      end

      local function fetchGitStatus(cwd, callback)
        local clean_cwd = cwd:gsub('^minifiles://%d+/', '')
        vim.system({ 'git', 'status', '--ignored', '--porcelain' }, { text = true, cwd = clean_cwd }, function(content)
          if content.code == 0 then
            callback(content.stdout)
          end
        end)
      end

      local function updateMiniWithGit(buf_id, gitStatusMap)
        vim.schedule(function()
          local nlines = vim.api.nvim_buf_line_count(buf_id)
          local cwd = vim.fs.root(buf_id, '.git')
          local escapedcwd = cwd and vim.pesc(cwd)
          if escapedcwd then
            escapedcwd = vim.fs.normalize(escapedcwd)
          end

          for i = 1, nlines do
            local entry = MiniFiles.get_fs_entry(buf_id, i)
            if not entry then
              break
            end
            local relativePath = entry.path:gsub('^' .. escapedcwd .. '/', '')
            local status = gitStatusMap[relativePath]

            if status then
              local symbol, hlGroup = mapSymbols(status, isSymlink(entry.path))
              vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, 0, {
                sign_text = symbol,
                sign_hl_group = hlGroup,
                priority = 2,
              })
              local line = vim.api.nvim_buf_get_lines(buf_id, i - 1, i, false)[1]
              local nameStartCol = line:find(vim.pesc(entry.name)) or 0

              if nameStartCol > 0 then
                vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, nameStartCol - 1, {
                  end_col = nameStartCol + #entry.name - 1,
                  hl_group = hlGroup,
                })
              end
            end
          end
        end)
      end

      local function parseGitStatus(content)
        local gitStatusMap = {}
        for line in content:gmatch '[^\r\n]+' do
          local status, filePath = string.match(line, '^(..)%s+(.*)')
          local parts = {}
          for part in filePath:gmatch '[^/]+' do
            table.insert(parts, part)
          end

          local currentKey = ''
          for i, part in ipairs(parts) do
            currentKey = (i > 1) and (currentKey .. '/' .. part) or part
            if i == #parts then
              gitStatusMap[currentKey] = status
            else
              if not gitStatusMap[currentKey] then
                gitStatusMap[currentKey] = status
              end
            end
          end
        end
        return gitStatusMap
      end

      local function updateGitStatus(buf_id)
        if not vim.fs.root(buf_id, '.git') then
          return
        end
        local cwd = vim.fs.root(buf_id, '.git')
        local currentTime = os.time()

        if gitStatusCache[cwd] and currentTime - gitStatusCache[cwd].time < cacheTimeout then
          updateMiniWithGit(buf_id, gitStatusCache[cwd].statusMap)
        else
          fetchGitStatus(cwd, function(content)
            local gitStatusMap = parseGitStatus(content)
            gitStatusCache[cwd] = { time = currentTime, statusMap = gitStatusMap }
            updateMiniWithGit(buf_id, gitStatusMap)
          end)
        end
      end

      local function augroup(name)
        return vim.api.nvim_create_augroup('MiniFiles_' .. name, { clear = true })
      end

      autocmd('User', {
        group = augroup 'start',
        pattern = 'MiniFilesExplorerOpen',
        callback = function()
          updateGitStatus(vim.api.nvim_get_current_buf())
        end,
      })

      autocmd('User', {
        group = augroup 'close',
        pattern = 'MiniFilesExplorerClose',
        callback = function()
          gitStatusCache = {}
        end,
      })

      autocmd('User', {
        group = augroup 'update',
        pattern = 'MiniFilesBufferUpdate',
        callback = function(args)
          local bufnr = args.data.buf_id
          local cwd = vim.fs.root(bufnr, '.git')
          if gitStatusCache[cwd] then
            updateMiniWithGit(bufnr, gitStatusCache[cwd].statusMap)
          end
        end,
      })
      require('mini.indentscope').setup {
        symbol = '│',
        options = { try_as_border = true },
      }
      require('mini.icons').setup {}

      require('mini.hipatterns').setup {}

      -- Keymap to open mini.files
      vim.keymap.set('n', '-', function()
        -- Opens mini.files in the directory of the currently active buffer
        require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
      end, { desc = 'Open mini.files (Directory of current file)' })
    end,
  },
}
