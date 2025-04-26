local various = require("various-textobjs")
local keymap = require("lib.utils").keymap

local inoutMaps = {
    subword = "S",
    number = "n",
    lineCharacterwise = "_",
    greedyOuterIndentation = "g",
    anyQuote = "q",
    value = "v",
    key = "k",
}

for fn, map in pairs(inoutMaps) do
    keymap({ "o", "x" }, "a" .. map, function() various[fn]("outer") end, nil, "[TOBJ] outer " .. fn)
    keymap({ "o", "x" }, "i" .. map, function() various[fn]("inner") end, nil, "[TOBJ] inner " .. fn)
end

local oneMaps = {
    nearEoL = "n",
    visibleInWindow = "gw",
    toNextQuotationMark = '"',
    restOfIndentation = "R",
    column = "|",
    entireBuffer = "gG",
    url = "L",
}

for fn, map in pairs(oneMaps) do
    keymap({ "o", "x" }, map, function() various[fn]() end, nil, "[TOBJ] " .. fn)
end

local ftMaps = {
    { map = { mdLink = "l" },               fts = { "markdown" } },
    { map = { mdEmphasis = "e" },           fts = { "markdown" } },
    { map = { mdFencedCodeBlock = "C" },    fts = { "markdown" } },
    { map = { doubleSquareBrackets = "D" }, fts = { "lua", "norg", "sh", "fish", "zsh", "bash", "markdown" } },
    { map = { cssSelector = "c" },          fts = { "css", "scss" } },
    { map = { cssColor = "#" },             fts = { "css", "scss" } },
    { map = { shellPipe = "P" },            fts = { "sh", "bash", "zsh", "fish" } },
    { map = { htmlAttribute = "x" },        fts = { "html", "css", "scss", "xml", "vue" } },
}

local group = vim.api.nvim_create_augroup("VariousTextobjs", {})
for _, textobj in pairs(ftMaps) do
    vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = textobj.fts,
        callback = function()
            for objName, map in pairs(textobj.map) do
                local name = " " .. objName .. " textobj"
                keymap(
                    { "o", "x" },
                    "a" .. map,
                    function() various[objName]("outer") end, { buffer = true },
                    "[TOBJ] outer " .. name)

                keymap(
                    { "o", "x" },
                    "i" .. map,
                    function() various[objName]("inner") end,
                    { buffer = true },
                    "[TOBJ] inner " .. name)
            end
        end,
    })
end
