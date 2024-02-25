return {
  -- add gruvbox
  { "ellionleao/gruvbox.nvim" },

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
    tag = "0.1.x",
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
      "nvim-telescope/telescope.nvim"
    },
    config = function ()
      local harpoon = require('harpoon');

      harpoon:setup({});
    end
  },
}
