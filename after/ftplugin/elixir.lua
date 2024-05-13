vim.cmd [[
augroup elixir_fmt
  autocmd!
  autocmd BufWritePre *.ex :Format
  autocmd BufWritePre *.exs :Format
augroup END
]]
