-- set relative number lines on normal mode but not insert mode
vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
  command = 'set number norelativenumber',
})

vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
  callback = function(ev)
    -- remove line numbers in lazygit window
    if string.match(ev.file, 'lazygit$') then
      vim.o.relativenumber = false
      vim.o.number = false
    else
      vim.o.relativenumber = true
    end
  end,
})
