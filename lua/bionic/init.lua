local M       = {}

local parsers = require('nvim-treesitter.parsers')
local bionic  = "Bionic"

local api     = vim.api
local ts      = vim.treesitter
local ns_id   = vim.api.nvim_create_namespace(bionic)

--- @type table<integer,{lang:string, parser:LanguageTree}>
local buffers = {}

vim.cmd('highlight ' .. bionic .. ' gui=bold')

---@param ts_node TSNode
local function set_bold(ts_node)
    local start_row, start_col, end_row, end_col = ts_node:range()
    local bolds = 0
    if end_col - start_col > 6 then
        bolds = 3
    elseif end_col - start_col > 4 then
        bolds = 2
    elseif end_col - start_col > 2 then
        bolds = 1
    end

    for c in ts_node:iter_children() do
        local c_start_row, c_start_col = set_bold(c)
        if c_start_row == start_row and c_start_col <= start_col + 1 then
            bolds = 0
        end
    end
    vim.api.nvim_buf_add_highlight(0, ns_id, bionic, start_row, start_col, start_col + bolds)
    return start_row, start_col
end

---@param bufnr integer
local function update(bufnr)
    local lang_tree = buffers[bufnr].parser
    local trees = lang_tree:trees()
    local ts_node = trees[1]:root()
    set_bold(ts_node)
end

local function start()
    local bufnr = api.nvim_get_current_buf()
    local lang = parsers.get_buf_lang(bufnr)
    local parser = ts.get_parser(bufnr, lang)
    buffers[bufnr] = { lang = lang, parser = parser }
    vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
    update(bufnr)

    parser:register_cbs({
        on_changedtree = function()
            vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
            update(bufnr)
            vim.defer_fn(
            function()     -- HACK: For some reason formatting clears the HL, This is to update it after that is done
                update(bufnr)
            end, 0)
        end
    })
end

local is_on = false

function M.on()
    is_on = true
    start()
end

function M.off()
    is_on = false
    vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
    buffers = {}
end

function M.toggle()
    if is_on then
        M.off()
    else
        M.on()
    end
end


return M
