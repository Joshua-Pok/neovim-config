local function local_llm_streaming_handler(chunk, line, assistant_output, bufnr, winid, F)
  if not chunk then
    return assistant_output
  end
  local tail = chunk:sub(-1, -1)
  if tail:sub(1, 1) ~= '}' then
    line = line .. chunk
  else
    line = line .. chunk
    local status, data = pcall(vim.fn.json_decode, line)
    if not status or not data.message.content then
      return assistant_output
    end
    assistant_output = assistant_output .. data.message.content
    F.WriteContent(bufnr, winid, data.message.content)
    line = ''
  end
  return assistant_output
end

local function local_llm_parse_handler(chunk)
  local assistant_output = chunk.message.content
  return assistant_output
end

return {
  {
    'Kurama622/llm.nvim',
    -- If code completion uses Codeium, it requires `Exafunction/codeium.nvim`; otherwise, it does not.
    dependencies = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim', 'Exafunction/codeium.nvim' },
    cmd = { 'LLMSessionToggle', 'LLMSelectedTextHandler', 'LLMAppHandler' },
    config = function()
      local tools = require 'llm.tools'
      -- vim.api.nvim_set_hl(0, "Query", { fg = "#6aa84f", bg = "NONE" })
      require('llm').setup {
        enable_trace = true,
        -- -- [[ cloudflare ]]     params: api_type =  "workers-ai" | "openai" | "zhipu" | "ollama"
        -- -- model = "@cf/qwen/qwen1.5-14b-chat-awq",
        -- model = "@cf/google/gemma-7b-it-lora",
        -- api_type = "workers-ai",
        -- fetch_key = function()
        --   return vim.env.WORKERS_AI_KEY
        -- end,

        -- [[ openrouter]]
        url = 'https://openrouter.ai/api/v1/chat/completions',
        model = 'openai/gpt-oss-20b:free',
        max_tokens = 8000,
        api_type = 'openai',
        fetch_key = function()
          return vim.env.LLM_KEY
        end,

        temperature = 0.3,
        top_p = 0.7,

        prompt = 'You are a master software engineer tasked with mentoring me to be a better engineer.',

        spinner = {
          text = {
            '󰧞󰧞',
            '󰧞󰧞',
            '󰧞󰧞',
            '󰧞󰧞',
          },
          hl = 'Title',
        },

        prefix = {
          --
          user = { text = '😃 ', hl = 'Title' },
          assistant = { text = '  ', hl = 'Added' },
        },

        display = {
          diff = {
            layout = 'vertical', -- vertical|horizontal split for default provider
            opts = { 'internal', 'filler', 'closeoff', 'algorithm:patience', 'followwrap', 'linematch:120' },
            provider = 'mini_diff', -- default|mini_diff
          },
        },
        -- style = "right",
        --[[ custom request args ]]
        -- args = [[return {url, "-N", "-X", "POST", "-H", "Content-Type: application/json", "-H", authorization, "-d", vim.fn.json_encode(body)}]],
        -- history_path = "/tmp/llm-history",
        save_session = true,
        max_history = 15,
        max_history_name_length = 20,

        -- stylua: ignore
        -- popup window options
        popwin_opts = {
          relative = "cursor", enter = true,
          focusable = true, zindex = 50,
          position = { row = -7, col = 15, },
          size = { height = 15, width = "50%", },
          border = { style = "single",
            text = { top = " Explain ", top_align = "center" },
          },
          win_options = {
            winblend = 0,
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },

        -- stylua: ignore
        keys = {
          -- The keyboard mapping for the input window.
          ["Input:Submit"]      = { mode = {"n", "i"}, key = "<cr>" },
          ["Input:Cancel"]      = { mode = {"n", "i"}, key = "<C-c>" },
          ["Input:Resend"]      = { mode = {"n", "i"}, key = "<C-r>" },

          -- only works when "save_session = true"
          ["Input:HistoryNext"] = { mode = {"n", "i"}, key = "<C-j>" },
          ["Input:HistoryPrev"] = { mode = {"n", "i"}, key = "<C-k>" },

          -- The keyboard mapping for the output window in "split" style.
          ["Output:Ask"]        = { mode = "n", key = "i" },
          ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
          ["Output:Resend"]     = { mode = "n", key = "<C-r>" },

          -- The keyboard mapping for the output and input windows in "float" style.
          ["Session:Toggle"]    = { mode = "n", key = "<leader>ac" },
          ["Session:Close"]     = { mode = "n", key = {"<esc>", "Q"} },

          -- Scroll [default]
          ["PageUp"]            = { mode = {"i","n"}, key = "<C-b>" },
          ["PageDown"]          = { mode = {"i","n"}, key = "<C-f>" },
          ["HalfPageUp"]        = { mode = {"i","n"}, key = "<C-u>" },
          ["HalfPageDown"]      = { mode = {"i","n"}, key = "<C-d>" },
          ["JumpToTop"]         = { mode = "n", key = "gg" },
          ["JumpToBottom"]      = { mode = "n", key = "G" }
        },

        app_handler = {
          OptimizeCode = {
            handler = tools.side_by_side_handler,
            opts = {
              -- streaming_handler = local_llm_streaming_handler,
              left = {
                focusable = false,
              },
            },
          },
          CodeExplain = {
            handler = tools.flexi_handler,
            prompt = 'Explain the following code, please only return the explanation, and answer in Chinese',
            opts = {
              fetch_key = function()
                return vim.env.GLM_KEY
              end,
              url = 'https://openrouter.ai/api/v1/chat/completions',
              model = 'openai/gpt-oss-20b:free',
              api_type = 'openai',
              enter_flexible_window = true,
            },
          },
          Ask = {
            handler = tools.disposable_ask_handler,
            opts = {
              position = {
                row = 2,
                col = 0,
              },
              title = ' Ask ',
              inline_assistant = true,
              language = 'Chinese',
              url = 'https://openrouter.ai/api/v1/chat/completions',
              model = 'openai/gpt-oss-20b:free',
              api_type = 'openai',
              fetch_key = function()
                return vim.env.LLM_KEY
              end,
              display = {
                mapping = {
                  mode = 'n',
                  keys = { 'd' },
                },
                action = nil,
              },
              accept = {
                mapping = {
                  mode = 'n',
                  keys = { 'Y', 'y' },
                },
                action = nil,
              },
              reject = {
                mapping = {
                  mode = 'n',
                  keys = { 'N', 'n' },
                },
                action = nil,
              },
              close = {
                mapping = {
                  mode = 'n',
                  keys = { '<esc>' },
                },
                action = nil,
              },
            },
          },
          AttachToChat = {
            handler = tools.attach_to_chat_handler,
            opts = {
              is_codeblock = true,
              inline_assistant = true,
              language = 'English',
            },
          },
        },
      }
    end,
    keys = {
      { '<leader>ac', mode = 'n', '<cmd>LLMSessionToggle<cr>', desc = ' Toggle LLM Chat' },
      { '<leader>ae', mode = 'v', '<cmd>LLMAppHandler CodeExplain<cr>', desc = ' Explain the Code' },
      { '<leader>tc', mode = 'x', '<cmd>LLMAppHandler TestCode<cr>', desc = ' Generate Test Cases' },
      { '<leader>ao', mode = 'x', '<cmd>LLMAppHandler OptimCompare<cr>', desc = ' Optimize the Code' },
      { '<leader>ak', mode = { 'v', 'n' }, '<cmd>LLMAppHandler Ask<cr>', desc = ' Ask LLM' },
      { '<leader>aa', mode = { 'v', 'n' }, '<cmd>LLMAppHandler AttachToChat<cr>', desc = ' Ask LLM (multi-turn)' },
      -- { "<leader>ao", mode = "x", "<cmd>LLMAppHandler OptimizeCode<cr>" },
      -- { "<leader>ae", mode = "v", "<cmd>LLMSelectedTextHandler 请解释下面这段代码<cr>" },
      -- { "<leader>ts", mode = "x", "<cmd>LLMSelectedTextHandler 英译汉<cr>" },
    },
  },
}
