MASON_PATH = os.getenv("HOME") .. "/.local/share/nvim/mason/packages"
TRANSPARENT = true

_G.winblend = function()
    if TRANSPARENT then
        return 0
    end

    return 10
end
