local js_languages = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
}

return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.mapping = cmp.mapping.preset.insert(vim.tbl_deep_extend("force", opts.mapping, {
        ["<CR>"] = cmp.config.disable,
      }))
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>pwf",
        function()
          local utils = require("telescope.utils")
          print(utils)
          require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
        end,
        desc = "Telescope grep word",
      },
      {
        "<leader>pWf",
        function()
          require("telescope.builtin").grep_string({ search = vim.fn.expand("<cWORD>") })
        end,
        desc = "Telescope grep WORD",
      },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup({})
    end,
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "eugeny-dementev/neotest-jest",
      branch = "fix/path-normalize",
    },
    keys = {
      {
        "<leader>tt",
        function()
          local fullPath = vim.fs.normalize(vim.fn.expand("%"))
          local cwd = vim.fs.normalize(vim.fn.getcwd()) .. "/"

          local pattern = vim.fn.substitute(fullPath, cwd, "", "g")

          require("neotest").run.run(pattern)
        end,
        desc = "Run File",
      },
    },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.js",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        })
      )
    end,
  },

  -- Custom Parameters (with defaults)
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "codellama:7b-code", -- The default model to use.
      host = "192.168.88.113", -- The host running the Ollama service.
      port = "8434", -- The port on which the Ollama service is listening.
      quit_map = "q", -- set keymap for close the response window
      retry_map = "<c-r>", -- set keymap to re-send the current prompt
      -- init = function(options)
      --   pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
      -- end,
      -- Function to initialize Ollama
      command = function(options)
        local body = { model = options.model, stream = true }
        return "curl --silent --no-buffer -X POST http://"
          .. options.host
          .. ":"
          .. options.port
          .. "/api/chat -d $body"
      end,
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a command string.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      -- list_models = '<omitted lua function>', -- Retrieves a list of model names
      display_mode = "float", -- The display mode. Can be "float" or "split".
      show_prompt = false, -- Shows the prompt submitted to Ollama.
      show_model = false, -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = false, -- Never closes the window automatically.
      debug = false, -- Prints errors and the command which is run.
    },
  },

  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>da",
        function()
          local dap_vscode = require("dap.ext.vscode")

          if vim.fn.filereadable(".vscode/launch.json") then
            dap_vscode.load_launchjs(nil, {
              ["pwa-node"] = js_languages,
              ["node"] = js_languages,
            })

            require("dap").continue()
          end
        end,
        desc = "Run with Args",
      },
    },
  },
  'prisma/vim-prisma',
}
