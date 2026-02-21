vim.keymap.set('n', 'k', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = 'Move up through wrapped lines', expr = true })
vim.keymap.set('n', 'j', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = 'Move down through wrapped lines', expr = true })

vim.keymap.set('n', 'x', '"_x', { desc = 'Delete without copying' })
vim.keymap.set('n', '<leader>o', 'o<Esc>', { desc = 'Insert bottom newline' })
vim.keymap.set('n', '<leader>O', 'O<Esc>', { desc = 'Insert top newline' })
-- vim.keymap.set('n', '<leader>s', 'i<Space><Esc>', { desc = 'Insert whitespace on cursor' })
-- vim.keymap.set('n', '<leader>S', 'a<Space><Esc>', { desc = 'Insert whitespace after cursor' })
vim.keymap.set('n', '<C-S>', '<cmd>write<cr>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>mj', '"zdd"zp', { desc = 'Move line down' })
vim.keymap.set('n', '<leader>mk', '"zddk"zP', { desc = 'Move line up' })
-- vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>', { desc = 'Select all' })
vim.keymap.set('n', '<leader>a', 'mzggVG"+y`z', { desc = 'Select all' })
vim.keymap.set('n', '<C-x>', '<cmd>bdelete<cr>', { desc = 'Delete current buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete current buffer' })
vim.keymap.set('n', '<leader>bl', '<cmd>buffer #<cr>', { desc = 'Switch back to last buffer' })
vim.keymap.set('n', '<leader>bn', '<cmd>bn<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', '<cmd>bp<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<Tab>', '<cmd>bn<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', '<cmd>bp<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', "<leader>'", "cw'<Esc>pa'<Esc>", { desc = 'Wrap next word in single quotes' })
vim.keymap.set('n', '<leader>"', 'cw"<Esc>pa"<Esc>', { desc = 'Wrap next word in double quotes' })
vim.keymap.set('n', '<leader>r', ':FTermRun ', { desc = 'Run command in floating terminal' })
vim.keymap.set('n', ';', ':')

vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'Move left' })
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'Move right' })
vim.keymap.set('i', '<C-j>', '<Down>', { desc = 'Move down' })
vim.keymap.set('i', '<C-k>', '<Up>', { desc = 'Move up' })
vim.keymap.set('i', '<C-d>', '<Delete>', { desc = 'Delete in insert mode' })
vim.keymap.set('i', '<C-x>', '<Backspace>', { desc = 'Backspace in insert mode' })

vim.keymap.set('v', '<', '<gv', { desc = 'Indent line' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent line' })

vim.keymap.set('x', 'p', 'P', { desc = 'Paste without yanking in visual mode' })

vim.keymap.set('n', '<leader>l', function()
  vim.diagnostic.open_float()
end)

vim.keymap.set('n', 'L', function()
  vim.diagnostic.config { virtual_lines = { current_line = true }, virtual_text = false }

  vim.api.nvim_create_autocmd('CursorMoved', {
    group = vim.api.nvim_create_augroup('line-diagnostics', { clear = true }),
    callback = function()
      vim.diagnostic.config { virtual_lines = false, virtual_text = true }
      return true
    end,
  })
end)
