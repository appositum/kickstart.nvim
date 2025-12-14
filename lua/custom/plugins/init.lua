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
      { '<leader>g', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      MODE_MAP =
        {
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
        }, require('lualine').setup {
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
                  modified = ' ',
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
}
