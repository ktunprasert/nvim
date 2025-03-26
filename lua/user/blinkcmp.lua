return {
    keymap = {
        preset = 'enter',
        ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },
        ['<CR>'] = { 'accept', 'fallback_to_mappings' },
        ['<Tab>'] = { 'snippet_forward', 'select_next' },
        ['<S-Tab>'] = { 'snippet_backward', 'select_prev' },
        ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
        ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
        ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
        ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
        ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
        ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
        ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
        ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
        ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
        ['<A-0>'] = { function(cmp) cmp.accept({ index = 10 }) end },
    },

    cmdline = { enabled = true },

    appearance = {
        nerd_font_variant = 'mono'
    },
    completion = {
        menu = {
            draw = {
                columns = {
                    { 'item_idx' },
                    {
                        'label',
                        'label_description',
                        gap = 20
                    },
                    { 'kind_icon' },
                    { 'kind' },
                    -- { 'source_name' },
                },
                components = {
                    item_idx = {
                        text = function(ctx)
                            return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or
                                tostring(ctx.idx)
                        end,
                        highlight = 'BlinkCmpItemIdx' -- optional, only if you want to change its color
                    },
                    label = {
                        text = function(ctx)
                            return require("colorful-menu").blink_components_text(ctx)
                        end,
                        highlight = function(ctx)
                            return require("colorful-menu").blink_components_highlight(ctx)
                        end,
                    }
                },
            },
        },
        ghost_text = { enabled = true },
        documentation = { auto_show = true },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    -- TODO: bring in copilot
    sources = {
        default = function(_)
            local success, node = pcall(vim.treesitter.get_node)
            if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                return { 'copilot', 'path', 'snippets', 'buffer' }
            elseif vim.bo.filetype == 'lua' then
                return { 'copilot', 'lsp', 'path', 'snippets' }
            else
                return { 'copilot', 'lsp', 'path', 'snippets', 'buffer' }
            end
        end,
        providers = {
            buffer = {
                opts = {
                    get_bufnrs = function()
                        return vim.tbl_filter(function(bufnr)
                            return vim.bo[bufnr].buftype == ''
                        end, vim.api.nvim_list_bufs())
                    end
                }
            },
            copilot = {
                name = "copilot",
                module = "blink-cmp-copilot",
                score_offset = 100,
                async = true,
                transform_items = function(ctx, items)
                    for _, item in ipairs(items) do
                        item.kind_icon = ''
                        item.kind_name = 'Copilot'
                    end
                    return items
                end
            },
        },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
}
