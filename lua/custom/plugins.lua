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
    'sainnhe/everforest',
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
            {
              'filename',
              symbols = {
                modified = '●',
                readonly = '󰌾',
              },
              fmt = function(filename)
                local buffer_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
                local shell_name = buffer_name:match '^term.*/(.*)$'

                if shell_name then
                  return '  ' .. shell_name
                else
                  return filename
                end
              end,
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
              -- symbols = {
              --   -- TODO: create function to get lsp status percentage
              --   spinners = { "", "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥" }
              --   done = '',
              -- },
              function()
                local msg = ''
                local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
                local clients = vim.lsp.get_clients()

                if next(clients) == nil then
                  return msg
                end

                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes

                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return msg .. ' ' .. client.name
                  end
                end

                return msg
              end,
              color = function(_section)
                if next(vim.lsp.get_clients()) == nil then
                  return { fg = '#45475a' }
                end
              end,
            },
          },
          lualine_y = {
            { -- session name
              function()
                local session_name = require('auto-session.lib').current_session_name(true)
                local session = session_name == '' and session_name or ' ' .. session_name
                --  󰉖  󰉋 󰉓 
                return session
              end,
            },
            { -- current working directory name for the buffer
              function()
                -- % = current buffer
                -- p = full path
                -- h = head (remove last component (filename))
                -- t = tail (last component only)
                local cwd_name = vim.fn.expand '%:p:~:h:t'

                if cwd_name == '~' then
                  return ''
                end

                if cwd_name == '' then
                  cwd_name = 'root'
                end

                return '󰉋 ' .. cwd_name
              end,
            },
          },
          lualine_z = {
            -- 
            -- 
            -- 󰦪
            {
              'location',
              icon = '',
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
          path = '~/Nextcloud/Notas/',
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
      { '<leader>ss', '<cmd>AutoSession search<CR>', desc = '[s]earch [s]ession' },
      { '<leader>sw', '<cmd>AutoSession save<CR>', desc = 'Save session (write)' },
      { '<leader>sa', '<cmd>AutoSession toggle<CR>', desc = 'Toggle [s]ession [a]utosave' },
    },

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/' },
      session_lens = {
        picker = 'telescope',
        mappings = {
          delete_session = { 'n', '<leader>d' },
          copy_session = { 'n', '<leader>y' },
        },
        picker_opts = {
          initial_mode = 'normal',
        },
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local bufferline = require 'bufferline'
      bufferline.setup {
        highlights = {
          fill = {
            -- bg = '#181825', -- catppuccin
            bg = '#16161D', -- kanagawa
          },
          tab_selected = {
            -- bg = '#fab387', -- catppuccin
            -- fg = '#181825', -- catppuccin
            bg = '#FFA066', -- kanagawa
            fg = '#16161D', -- kanagawa
          },
          tab_separator_selected = {
            -- bg = '#fab387', -- catppuccin
            bg = '#FFA066', -- kanagawa
          },
          indicator_selected = {
            -- fg = '#b4befe', -- catppuccin
            fg = '#7E9CD8', -- kanagawa
          },
        },
        options = {},
      }
    end,
  },
  {
    'Godswill-255/colorviewer.nvim',
    config = function()
      require('colorviewer').setup({
        symbol = '■',
      })
    end
  }
}
