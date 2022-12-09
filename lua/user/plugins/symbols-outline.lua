local ok, lualine = pcall(require, "symbols-outline")
if not ok then
    return
end

lualine.setup()
