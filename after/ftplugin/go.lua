vim.opt.shiftwidth = 4

vim.cmd [[
augroup go_fmt
  autocmd!
  autocmd BufWritePre *.go :Format
augroup END
]]
