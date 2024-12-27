return {
    "nvim-lualine/lualine.nvim", event = "VeryLazy",
    init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
            -- set an empty statusline till lualine loads
            vim.o.statusline = " "
        else
            -- hide the statusline on the starter page
            vim.o.laststatus = 0
        end
    end,
    opts = function()
        local opts = {
            options = {
                section_separators = { left = '', right = '' },
                component_separators = { left = '|', right = '|' },
                theme = "auto",
                globalstatus = vim.o.laststatus == 3,
                disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
            },
            sections = {
                lualine_z = {
                    "localtion",
                    {'datetime',
                    style = "%H:%M:%S"}
                }
            },

           extensions = { "neo-tree", "lazy", "fzf" },
        }
       return opts
    end,
}
