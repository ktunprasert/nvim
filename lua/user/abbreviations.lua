-- Abbreviation to get current filename without extension
-- useful for PHP when you have the class name as the file name
-- _fn - current filename without extension
-- _ns - current path without filename
-- _nss - current path without filename dirup 1
-- _nsss - current path without filename dirup 2
vim.cmd [[inoreabbr <expr> _fn expand('%:t:r') ]]
vim.cmd [[inoreabbr <expr> _ns expand('%:h') ]]
vim.cmd [[inoreabbr <expr> _nss expand('%:h:h') ]]
vim.cmd [[inoreabbr <expr> _nsss expand('%:h:h:h') ]]
