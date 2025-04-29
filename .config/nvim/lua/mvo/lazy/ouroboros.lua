return {
    -- This plugin is used to switch between header and source files in C/C++ projects
    "jakemason/ouroboros.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        require("ouroboros").setup({
            extension_preferences_table = {
                  c = {h = 2, hpp = 1},
                  h = {c = 2, cpp = 1},
                  cpp = {hpp = 2, h = 1},
                  hpp = {cpp = 2, c = 1},
            },
            switch_to_open_pane_if_possible = false,
        })
        -- Map <leader>jh to switch between header and source files
        vim.cmd([[
            autocmd! Filetype c,cpp nmap<buffer> <leader>jh :Ouroboros<CR>
            ]]
        )
    end
}
