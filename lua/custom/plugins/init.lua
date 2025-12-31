-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      MODE_MAP = {
        ['NORMAL'] = 'N',
        ['O-PENDING'] = 'N?',
        ['INSERT'] = 'I',
        ['VISUAL'] = 'V',
        ['V-BLOCK'] = 'VB',
        ['V-LINE'] = 'VL',
        ['V-REPLACE'] = 'VR',
        ['REPLACE'] = 'R',
        ['COMMAND'] = '!',
        ['SHELL'] = 'SH',
        ['TERMINAL'] = 'T',
        ['EX'] = 'X',
        ['S-BLOCK'] = 'SB',
        ['S-LINE'] = 'SL',
        ['SELECT'] = 'S',
        ['CONFIRM'] = 'Y?',
        ['MORE'] = 'M',
      }
      require('lualine').setup {
        options = {
          theme = 'catppuccin_mocha',
          icons_enabled = true,
          -- component_separators = { left = '', right = '' },
          -- section_separators = { left = '', right = '' },

          -- component_separators = { left = '', right = '' },
          -- section_separators = { left = '', right = '' },

          -- component_separators = { left = '', right = '' },
          -- section_separators = { left = '', right = '' },

          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            {
              'mode',
              fmt = function(s)
                return ' ' .. (MODE_MAP[s] or s)
              end,
            },
          },
          lualine_b = {
            {
              'filetype',
              icon_only = true,
              colored = false,
              separator = '',
              padding = {
                right = 0,
                left = 1,
              },
            },
            'filename',
            {
              'diagnostics',
              symbols = {
                error = ' ',
                warn = ' ',
                info = ' ',
              },
            },
          },
          lualine_c = {
            'branch',
            {
              'diff',
              symbols = {
                added = ' ',
                -- modified = ' ',
                modified = ' ',
                removed = ' ',
              },
            },
          },
          lualine_x = {
            -- icon =
            {
              function()
                local msg = 'No Active Lsp'
                local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then
                  return msg
                end
                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                  end
                end
                return msg
              end,
              icon = ' LSP:',
            },
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      }
    end,
  },
  {
    'Julian/lean.nvim',
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

    dependencies = {
      'nvim-lua/plenary.nvim',

      -- optional dependencies:

      -- a completion engine
      --    hrsh7th/nvim-cmp or Saghen/blink.cmp are popular choices

      -- 'nvim-telescope/telescope.nvim', -- for 2 Lean-specific pickers
      -- 'andymass/vim-matchup',          -- for enhanced % motion behavior
      -- 'andrewradev/switch.vim',        -- for switch support
      -- 'tomtom/tcomment_vim',           -- for commenting
    },

    ---@type lean.Config
    opts = { -- see below for full configuration options
      mappings = true,
    },
  },
  {
    'rhysd/git-messenger.vim',
  },
  {
    'pwntester/octo.nvim',
    cmd = 'Octo',
    opts = {
      -- or "fzf-lua" or "snacks" or "default"
      picker = 'telescope',
      -- bare Octo command opens picker of commands
      enable_builtin = true,
    },
    keys = {
      {
        '<leader>gi',
        '<CMD>Octo issue list<CR>',
        desc = 'List GitHub Issues',
      },
      {
        '<leader>gp',
        '<CMD>Octo pr list<CR>',
        desc = 'List GitHub PullRequests',
      },
      -- {
      --   "<leader>gd",
      --   "<CMD>Octo discussion list<CR>",
      --   desc = "List GitHub Discussions",
      -- },
      {
        '<leader>gn',
        '<CMD>Octo notification list<CR>',
        desc = 'List GitHub Notifications',
      },
      {
        '<leader>gs',
        function()
          require('octo.utils').create_base_search_command { include_current_repo = true }
        end,
        desc = 'Search GitHub',
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      -- OR "ibhagwan/fzf-lua",
      -- OR "folke/snacks.nvim",
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'appositum/gh-dash.nvim',
    lazy = true,
    keys = {
      {
        '<leader>gh',
        function()
          require('gh_dash').toggle()
        end,
        desc = 'Toggle gh-dash popup',
      },
    },
    opts = {
      keymaps = {}, -- disable internal mapping
      border = 'rounded', -- or 'double'
      width = 0.9,
      height = 0.9,
      autoinstall = true,
    },
  },
  {
    'vimwiki/vimwiki',
    -- event = 'BufEnter *.md',
    -- keys = { '<leader>ww', '<leader>wt'},
    init = function()
      vim.g.vimwiki_list = {
        {
          path = '~/notes',
          syntax = 'markdown',
          ext = 'md',
        },
      }
    end,
  },
}
