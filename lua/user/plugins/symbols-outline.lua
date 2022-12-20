local ok, symbols = pcall(require, "symbols-outline")
if not ok then
    return
end

symbols.setup({
    auto_close = true,
})
