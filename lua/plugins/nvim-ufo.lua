return {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
        vim.o.foldcolumn = '0'    -- '1' if you want to have extra column for fold info
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 15 -- high value for dashboard, top 30 level folds are open, anything beyond that is closed
        vim.o.foldenable = true
        -- vim.o.foldnestmax = 5     -- no fold for more than 5 level of nesting

        local ftMap = {
            vim = 'indent',
            python = { 'lsp', 'indent' },
            rust = { 'lsp', 'indent' },
            lua = { 'lsp', 'indent' },
            git = '',
        }

        local function customizeSelector(bufnr)
            local function handleFallbackException(err, providerName)
                if type(err) == 'string' and err:match('UfoFallbackException') then
                    return require('ufo').getFolds(bufnr, providerName)
                else
                    return require('promise').reject(err)
                end
            end

            return require('ufo')
                .getFolds(bufnr, 'lsp')
                :catch(function(err)
                    return handleFallbackException(err, 'treesitter')
                end)
                :catch(function(err)
                    return handleFallbackException(err, 'indent')
                end)
        end

        local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (' 󰁂 %d '):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, { chunkText, hlGroup })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, { suffix, 'MoreMsg' })
            return newVirtText
        end

        -- Setup nvim-ufo
        require('ufo').setup({
            provider_selector = function(_, filetype, _)
                return ftMap[filetype] or customizeSelector
            end,
            fold_virt_text_handler = handler,
        })
    end,
}
