require 'custom.theme'

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
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        styles = {
          comments = { 'nocombine' }, -- Disable italics in comments
        },
      }
    end,
  },
  {
    'sainnhe/everforest',
    priority = 1000,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
  },
  {
    'thesimonho/kanagawa-paper.nvim',
    priority = 1000,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      MODE_MAP = {
        ['NORMAL'] = 'N ',
        ['O-PENDING'] = 'N?',
        ['INSERT'] = 'I ',
        ['VISUAL'] = 'V ',
        ['V-BLOCK'] = 'VB',
        ['V-LINE'] = 'VL',
        ['V-REPLACE'] = 'VR',
        ['REPLACE'] = 'R ',
        ['COMMAND'] = '! ',
        ['SHELL'] = 'SH',
        ['TERMINAL'] = 'T ',
        ['EX'] = 'X ',
        ['S-BLOCK'] = 'SB',
        ['S-LINE'] = 'SL',
        ['SELECT'] = 'S ',
        ['CONFIRM'] = 'Y?',
        ['MORE'] = 'M ',
      }
      require('lualine').setup {
        options = {
          theme = THEME_LUALINE,
          icons_enabled = true,
          -- component_separators = { left = '', right = '' },
          -- section_separators = { left = '', right = '' },

          -- component_separators = { left = '', right = '' },
          -- section_separators = { left = '', right = '' },

          -- component_separators = { left = '', right = '' },
          -- section_separators = { left = '', right = '' },

          component_separators = { left = '', right = '|' },
          section_separators = { left = '', right = '' },
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
              'buffers',
              use_mode_colors = true,
              symbols = {
                alternate_file = ' ',
              },
            },
          },
          lualine_c = {
            {
              'branch',
              component_separators = '',
            },
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
            {
              'diagnostics',
              symbols = {
                error = ' ',
                warn = ' ',
                info = ' ',
              },
              component_separators = '', -- no | between icons and LSP: <lsp_name>
            },
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
              icon = '',
              -- symbols = {
              --   -- TODO: create function to get lsp status percentage
              --   spinners = { "", "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥" }
              --   done = '',
              -- },
            },
          },

          lualine_y = {
            -- 󰉋
            -- 
            -- 󰉖

            -- current working directory name for the buffer
            function()
              -- % = current buffer
              -- p = full path
              -- h = head (remove last component (filename))
              -- t = tail (last component only)
              -- 󰉋  󰉖
              local session_name = require('auto-session.lib').current_session_name(true)
              local cwd_name = '󰉋 ' .. vim.fn.expand '%:p:h:t'
              return session_name .. ' | ' .. cwd_name
            end,
          },
          lualine_z = {
            -- 
            -- 
            -- 
            {
              'location',
              icon = '',
            },
          },
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
  {
    'mistweaverco/kulala.nvim',
    keys = {
      { '<leader>Rs', desc = 'Send request' },
      { '<leader>Ra', desc = 'Send all requests' },
      { '<leader>Rb', desc = 'Open scratchpad' },
    },
    ft = { 'http', 'rest' },
    opts = {
      global_keymaps = false,
      global_keymaps_prefix = '<leader>R',
      kulala_keymaps_prefix = '',
    },
  },
  {
    'numToStr/FTerm.nvim',
    keys = {
      { '<A-i>', '<cmd>FTermToggle<cr>', desc = '[T]oggle FTerm' },
      { '<A-i>', '<cmd>FTermToggle<cr>', mode = { 't' } },
      { '<A-k>', '<cmd>FTermExit<cr>', mode = { 't' } },
    },
  },
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- opts = {
    --   workspaces = {
    --     {
    --       name = "personal",
    --       path = "~/vaults/personal",
    --     },
    --     {
    --       name = "work",
    --       path = "~/vaults/work",
    --     },
    --   },
    -- },
  },
  {
    'rmagatti/auto-session',
    lazy = false,
    keys = {
      { '<leader>sf', '<cmd>AutoSession search<CR>', desc = '[s]ession [f]ind' },
      { '<leader>ss', '<cmd>AutoSession save<CR>', desc = '[s]ave [s]ession' },
      { '<leader>sa', '<cmd>AutoSession toggle<CR>', desc = 'Toggle [s]ession [a]utosave' },
    },

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      auto_restore_last_session = true,
      session_lens = {
        picker = 'telescope',
        mappings = {
          delete_session = { 'n', '<leader>d' },
          copy_session = { 'n', '<leader>c' },
        },
        picker_opts = {
          initial_mode = 'normal',
        },
      },
    },
  },
}
